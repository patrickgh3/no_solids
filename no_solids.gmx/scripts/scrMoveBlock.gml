/// scrMoveBlock(dX, dY)

var dX = argument0
var dY = argument1


if dX == 0 and dY == 0 {
    return 0
}


var playerRiding = instance_place(x, y - global.grav, objPlayer)

if dX != 0 {
    x += dX
    
    var collided = instance_place(x, y, objPlayer)
    
    if place_meeting(x, y, collided) and not place_meeting(x - dX, y, collided) {
    //if collided != noone {
        // Push right
        if dX > 0 {
            collided.x += bbox_right + 1 - collided.bbox_left
            collided.x = ceil(collided.x) // to prevent kinda-stuck at 0.5 speed
        }
        // Push left
        else {
            collided.x += bbox_left - (collided.bbox_right + 1)
            collided.x = floor(collided.x) // to prevent kinda-stuck at 0.5 speed
        }
        
        image_blend = c_lime
    }
    else {
        if playerRiding != noone {
            with playerRiding {
                scrMoveContactObject(dX, 0, objBlock)
            }
        }
    }
}


if dY != 0 {
    y += dY
    
    var collided = instance_place(x, y, objPlayer)
    
    if place_meeting(x, y, collided) and not place_meeting(x, y - dY, collided) {
    //if collided != noone {
        // Push down
        if dY > 0 {
            collided.y += bbox_bottom + 1 - collided.bbox_top
        }
        // Push up
        else {
            collided.y += bbox_top - (collided.bbox_bottom + 1)
        }
        
        image_blend = c_lime
    }
    else {
        if playerRiding != noone {
            with playerRiding {
                scrMoveContactObject(0, dY, objBlock)
            }
        }
    }
}
