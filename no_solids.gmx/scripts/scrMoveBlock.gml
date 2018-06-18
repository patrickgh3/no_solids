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


// Multiplying global.grav by this scalar is a hack to fix "popping off" riding blocks that accelerate downwards
var playerRiding = instance_place(x, y - global.grav * 1.5, objPlayer)


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


if object_index == objPushableBlock {
    var xPrev = x
    var yPrev = y
    
    scrMoveContactBlocks(dX, dY, false)
    
    dX = x - xPrev
    dY = y - yPrev
    
    x = xPrev
    y = yPrev
}


if dX != 0 {
    x += dX
    
    var collided = instance_place(x, y, objPlayer)
    
    if collided != noone and not place_meeting(x - dX, y, collided) {
        if pushRight and dX > 0 {
            collided.x += bbox_right + 1 - collided.bbox_left
            collided.x = ceil(collided.x) // hack to prevent weird stuck behavior on blocks moving at 0.5 speed
            
            image_blend = c_lime
        }
        else if pushLeft and dX < 0 {
            collided.x += bbox_left - (collided.bbox_right + 1)
            collided.x = floor(collided.x) // hack to prevent weird stuck behavior on blocks moving at 0.5 speed
            
            image_blend = c_lime
        }
    }
    else {
        // Only one block per step can carry the player horizontally, to avoid the player
        // "sliding" if standing on the seam of two adjacent blocks moving down-right.
        with playerRiding {
            if not carriedXThisStep {
                scrMoveContactBlocks(dX, 0, true)
                
                carriedXThisStep = true
                
                other.image_blend = c_aqua
            }
        }
    }
}


if dY != 0 {
    y += dY
    
    var collided = instance_place(x, y, objPlayer)
    
    if collided != noone and not place_meeting(x, y - dY, collided) {
        if pushDown and dY > 0 {
            collided.y += bbox_bottom + 1 - collided.bbox_top
            
            image_blend = c_lime
        }
        else if pushUp and dY < 0 {
            collided.y += bbox_top - (collided.bbox_bottom + 1)
            
            image_blend = c_lime
        }
    }
    else {
        with playerRiding {
            scrMoveContactBlocks(0, dY, true)
            
            other.image_blend = c_aqua
        }
    }
}
