/// scrMoveBlock(dX, dY, pushUpOnly)

show_debug_message('scrMoveBlock')

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
if vinesEnabled and playerRiding == noone {
    // This number is kinda hacky, I'm not sure how big/small it needs to be, but this works...
    var vineRideRange = 2
    
    playerRiding = instance_place(x - vineRideRange, y, objPlayer)
    
    if playerRiding == noone {
        playerRiding = instance_place(x + vineRideRange, y, objPlayer)
    }
}


if place_meeting(x, y, playerRiding) {
    playerRiding = noone
}


if dX != 0 {
    x += dX
    
    var collided = instance_place(x, y, objPlayer)
    
    if place_meeting(x, y, collided) and not place_meeting(x - dX, y, collided) {
    //if collided != noone {
        // Push right
        if dX > 0 and pushRight {
            collided.x += bbox_right + 1 - collided.bbox_left
            collided.x = ceil(collided.x) // hack to prevent weird stuck behavior on blocks moving at 0.5 speed
            
            image_blend = c_lime
        }
        // Push left
        else if dX < 0 and pushLeft {
            collided.x += bbox_left - (collided.bbox_right + 1)
            collided.x = floor(collided.x) // hack to prevent weird stuck behavior on blocks moving at 0.5 speed
            
            image_blend = c_lime
        }
    }
    else {
        // Only one block per step can carry the player horizontally, to avoid the player
        // "sliding" if standing on the seam of two adjacent blocks moving down-right.
        if playerRiding != noone and not playerRiding.carriedXThisStep {
            with playerRiding {
                scrMoveContactBlocks(dX, 0)
                
                carriedXThisStep = true
            }
            
            image_blend = c_aqua
        }
    }
}


if dY != 0 {
    y += dY
    
    var collided = instance_place(x, y, objPlayer)
    
    if place_meeting(x, y, collided) and not place_meeting(x, y - dY, collided) {
    //if collided != noone {
        // Push down
        if dY > 0 and pushDown {
            collided.y += bbox_bottom + 1 - collided.bbox_top
            
            image_blend = c_lime
        }
        // Push up
        else if dY < 0 and pushUp {
            collided.y += bbox_top - (collided.bbox_bottom + 1)
            
            image_blend = c_lime
        }
    }
    else {
        if playerRiding != noone {
            with playerRiding {
                scrMoveContactBlocks(0, dY)
            }
            
            image_blend = c_aqua
        }
    }
}
