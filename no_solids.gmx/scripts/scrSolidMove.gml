/// scrSolidMove(dX, dY, parentObj)
// parentObj should be objBlock, objPlatform, or objOneWayWall

var dX = argument0
var dY = argument1
var parentObj = argument2

if dX == 0 and dY == 0 {
    return 0
}


xRemainder += dX
yRemainder += dY

dX = round(xRemainder)
dY = round(yRemainder)

if dX == 0 and dY == 0 {
    return 0
}


var pushLeft, pushRight, pushUp, pushDown;

if parentObj == objBlock {
    pushLeft = true
    pushRight = true
    pushUp = true
    pushDown = true
}
else if parentObj == objPlatform {
    pushLeft = false
    pushRight = false
    pushUp = false
    pushDown = false
    if global.grav == 1 pushUp = true
    else pushDown = true
}
else if parentObj == objOneWayWall {
    pushLeft = wallLeft
    pushRight = wallRight
    pushUp = false
    pushDown = false
}
else {
    show_debug_message("parentObj not valid: " + string(parentObj))
    return 0
}


var carryPlayer = false
var carryPlayerOnTop = false

if parentObj == objBlock or parentObj == objPlatform {
    var overlapPlayer = place_meeting(x, y, objPlayer)
    
    carryPlayer = place_meeting(x, y - global.grav, objPlayer) and not overlapPlayer
    
    carryPlayerOnTop = carryPlayer
    
    if parentObj == objBlock {
        if not carryPlayer and hasVineLeft {
            carryPlayer = place_meeting(x - 1, y, objPlayer) and not overlapPlayer
        }
            
        if not carryPlayer and hasVineRight {
            carryPlayer = place_meeting(x + 1, y, objPlayer) and not overlapPlayer
        }
    }
}

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
    xRemainder -= dX
    x += dX
    
    var collided = place_meeting(x, y, objPlayer) and not place_meeting(x - dX, y, objPlayer)
    
    if collided {
        if dX > 0 and pushRight {
            var pushDX = x + sprite_width / 2 - (objPlayer.x - floor(sprite_get_width(sprPlayerMask) / 2))
            
            with objPlayer var squished = scrMoveContactBlocks(pushDX, 0, true)
            if squished scrKillPlayer()
            
            image_blend = c_lime
        }
        else if dX < 0 and pushLeft {
            var pushDX = x - sprite_width / 2 - (objPlayer.x + floor(sprite_get_width(sprPlayerMask) / 2)) - 1
            
            with objPlayer var squished = scrMoveContactBlocks(pushDX, 0, true)
            if squished scrKillPlayer()
            
            image_blend = c_lime
        }
    }
    else if carryPlayer and not (carryPlayerOnTop and objPlayer.carriedXOnTop) {
        if carryPlayerOnTop objPlayer.carriedXOnTop = true
        
        with objPlayer scrMoveContactBlocks(dX, 0, true)
        
        image_blend = c_aqua
    }
}


if dY != 0 {
    yRemainder -= dY
    y += dY
    
    var collided = place_meeting(x, y, objPlayer) and not place_meeting(x, y - dY, objPlayer)
    
    if collided {
        if dY > 0 and pushDown {
            var pushDY = y + sprite_height / 2 - (objPlayer.y - floor(sprite_get_height(sprPlayerMask) / 2))
            
            with objPlayer var squished = scrMoveContactBlocks(0, pushDY, true)
            
            image_blend = c_lime
        }
        else if dY < 0 and pushUp {
            var pushDY = y - sprite_height / 2 - (objPlayer.y + floor(sprite_get_height(sprPlayerMask) / 2)) - 1
            
            with objPlayer var squished = scrMoveContactBlocks(0, pushDY, true)
            if squished scrKillPlayer()
            
            image_blend = c_lime
        }
    }
    else if carryPlayer {
        with objPlayer scrMoveContactBlocks(0, dY, true)
        
        image_blend = c_aqua
    }
}
