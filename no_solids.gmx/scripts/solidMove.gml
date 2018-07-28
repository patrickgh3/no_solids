/// solidMove(dX, dY)
// Moves a solid object by a delta X and Y, carrying and pushing the player if nearby.

var dX = argument0
var dY = argument1

if dX == 0 and dY == 0  return 0

xRemainder += dX
yRemainder += dY

dX = round(xRemainder)
dY = round(yRemainder)

if dX == 0 and dY == 0  return 0


var pushLeft, pushRight, pushUp, pushDown;
pushLeft = wallLeft
pushRight = wallRight
pushUp = wallUp
pushDown = wallDown

show_debug_message('solidMove')

var carryPlayer = false
var carryPlayerOnTop = false

if (global.grav == 1 and pushUp) or (global.grav == -1 and pushDown) {
    var overlapPlayer = place_meeting(x, y, objPlayer)
    
    carryPlayer = place_meeting(x, y - global.grav, objPlayer) and not overlapPlayer
    
    if carryPlayer carryPlayerOnTop = true
}

if not carryPlayer and hasVineLeft {
    carryPlayer = place_meeting(x - 1, y, objPlayer) and not overlapPlayer
}
    
if not carryPlayer and hasVineRight {
    carryPlayer = place_meeting(x + 1, y, objPlayer) and not overlapPlayer
}

if object_index == objPushableBlock {
    var xPrev = x
    var yPrev = y
    
    moveContactSolids(dX, dY)
    
    dX = x - xPrev
    dY = y - yPrev
    
    x = xPrev
    y = yPrev
}

if dX != 0 {
    xRemainder -= dX
    x += dX
    
    for (var i = 0; i < 2; i++) {
        var obj = objPlayer
        if i == 1 obj = objPushableBlock
        
        with obj {
            show_debug_message('id')
            if id == other.id continue
            
            with other var collided = place_meeting(x, y, other) and not place_meeting(x - dX, y, other)
            
            if collided {
                var pushDX = 0
                var width = sprite_get_width(mask_index)
                if mask_index == -1 width = sprite_get_width(sprite_index)
                
                if dX > 0 and pushRight {
                    pushDX = other.x + other.sprite_width / 2 - (x - floor(width / 2))
                }
                else if dX < 0 and pushLeft {
                    pushDX = other.x - other.sprite_width / 2 - (x + floor(width / 2)) - 1
                }
                
                if pushDX != 0 {
                    show_debug_message('pushing')
                    if moveContactSolids(pushDX, 0) and object_index == objPlayer {
                        scrKillPlayer()
                    }
                    
                    if global.debugSolidVisuals other.image_blend = c_lime
                }
            }
            else if carryPlayer and not (object_index == objPlayer and carryPlayerOnTop and carriedXOnTop) {
                if carryPlayerOnTop carriedXOnTop = true
                
                moveContactSolids(dX, 0)
                
                if global.debugSolidVisuals other.image_blend = c_aqua
            }
        }
    }
}


if dY != 0 {
    yRemainder -= dY
    y += dY
    
    var collided = place_meeting(x, y, objPlayer) and not place_meeting(x, y - dY, objPlayer)
    
    if collided {
        if dY > 0 and pushDown {
            var playerHeight = sprite_get_height(objPlayer.mask_index)
            var pushDY = y + sprite_height / 2 - (objPlayer.y - floor(playerHeight / 2))
            
            with objPlayer var squished = moveContactSolids(0, pushDY)
            if squished scrKillPlayer()
            
            if global.debugSolidVisuals image_blend = c_lime
        }
        else if dY < 0 and pushUp {
            var playerHeight = sprite_get_height(objPlayer.mask_index)
            var pushDY = y - sprite_height / 2 - (objPlayer.y + floor(playerHeight / 2)) - 1
            
            with objPlayer var squished = moveContactSolids(0, pushDY)
            if squished scrKillPlayer()
            
            if global.debugSolidVisuals image_blend = c_lime
        }
    }
    else if carryPlayer {
        with objPlayer moveContactSolids(0, dY)
        
        if global.debugSolidVisuals image_blend = c_aqua
    }
}

// If we just "phased through" the player, snap the player on top of us
if dY * global.grav > 0
and (global.grav == 1 and pushUp) or (global.grav == -1 and pushDown) {
    with objPlayer {
        if place_meeting(x, y + dY, other.id) and not place_meeting(x, y, other.id) {
            moveContactSolids(0, dY)
            
            ySpeed = 0
            
            if global.debugSolidVisuals other.image_blend = c_aqua
        }
    }
}
