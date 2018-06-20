/// scrMoveBlock(dX, dY, pushUpOnly)

var dX = argument0
var dY = argument1
var pushUpOnly = argument2

if dX == 0 and dY == 0 {
    return 0
}

var pushLeft = true
var pushRight = true
var pushUp = true
var pushDown = true

if pushUpOnly {
    pushLeft = false
    pushRight = false
    if global.grav == 1 pushDown = false
    else pushUp = false
}

var collisionPlayerBefore = place_meeting(x, y, objPlayer)

var carryPlayer = place_meeting(x, y - global.grav * 1.01, objPlayer) and not collisionPlayerBefore

var vineDist = 1

if not carryPlayer and dX >= 0 {
    carryPlayer = place_meeting(x - vineDist, y, objPlayer) and not collisionPlayerBefore
}
    
if not carryPlayer and dX <= 0 {
    carryPlayer = place_meeting(x + vineDist, y, objPlayer) and not collisionPlayerBefore
}

/*
// Vine riding behind a moving block
if object_is_ancestor(object_index, objBlock) {
    // This number is kinda hacky, I'm not sure how big/small it needs to be, but this works...
    var vineRideRange = 2
    
    if playerRiding == noone and vineLeft != noone {
        playerRiding = instance_place(x - vineRideRange, y, objPlayer)
        with playerRiding scrMoveContactBlocks(vineRideRange, 0, true)
    }
    
    if playerRiding == noone and vineRight != noone {
        playerRiding = instance_place(x + vineRideRange, y, objPlayer)
        with playerRiding scrMoveContactBlocks(-vineRideRange, 0, true)
    }
}

if place_meeting(x, y, playerRiding) {
    playerRiding = noone
}

*/

/*
if object_index == objPushableBlock {
    var xPrev = x
    var yPrev = y
    
    scrMoveContactBlocks(dX, dY, false)
    
    dX = x - xPrev
    dY = y - yPrev
    
    x = xPrev
    y = yPrev
}
*/


if dX != 0 {
    x += dX
    
    var collided = place_meeting(x, y, objPlayer) and not place_meeting(x - dX, y, objPlayer)
    
    if collided {
        if dX > 0 and pushRight {
            var pushDX = x + sprite_width / 2 - (objPlayer.x - sprite_get_width(sprPlayerMask) / 2) + 1
            
            with objPlayer scrMoveContactBlocks(pushDX, 0, true)
            
            image_blend = c_lime
        }
        else if dX < 0 and pushLeft {
            var pushDX = x - sprite_width / 2 - (objPlayer.x + sprite_get_width(sprPlayerMask) / 2) - 1
            
            with objPlayer scrMoveContactBlocks(pushDX, 0, true)
            
            image_blend = c_lime
        }
    }
    else if carryPlayer and not objPlayer.carriedXThisStep {
        objPlayer.carriedXThisStep = true
        
        with objPlayer scrMoveContactBlocks(dX, 0, true)
        
        image_blend = c_aqua
    }
}


if dY != 0 {
    y += dY
    
    var collided = place_meeting(x, y, objPlayer) and not place_meeting(x, y - dY, objPlayer)
    
    if collided {
        if dY > 0 and pushDown {
            //var pushDY = bbox_bottom - objPlayer.bbox_top + 1
            var pushDY = y + sprite_height / 2 - (objPlayer.y - sprite_get_height(sprPlayerMask) / 2) + 1
            
            with objPlayer scrMoveContactBlocks(0, pushDY, true)
            
            image_blend = c_lime
        }
        else if dY < 0 and pushUp {
            //var pushDY = bbox_top - objPlayer.bbox_bottom - 1
            var pushDY = y - sprite_height / 2 - (objPlayer.y + sprite_get_height(sprPlayerMask) / 2) - 1
            
            with objPlayer scrMoveContactBlocks(0, pushDY, true)
            
            image_blend = c_lime
        }
    }
    else if carryPlayer {
        show_debug_message(dY)
        
        with objPlayer scrMoveContactBlocks(0, dY, true)
            
        image_blend = c_aqua
    }
}
