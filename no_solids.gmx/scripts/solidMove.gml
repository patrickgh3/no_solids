/// solidMove(dX, dY, solidType)
// Moves a solid object by a delta X and Y, carrying and pushing the player if nearby.
// solidType should be objBlock or objOneWayWall.

var dX = argument0
var dY = argument1
var solidType = argument2

if solidType != objBlock and solidType != objOneWayWall {
    show_debug_message("Script solidMove: parentObj not valid: " + string(parentObj))
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

if solidType == objBlock {
    pushLeft = true
    pushRight = true
    pushUp = true
    pushDown = true
}
else if solidType == objOneWayWall {
    pushLeft = wallLeft
    pushRight = wallRight
    pushUp = wallUp
    pushDown = wallDown
    
    if wallGravityDir {
        if global.grav == 1 pushUp = true
        else pushDown = true
    }
}


var carryPlayer = false
var carryPlayerOnTop = false

if (global.grav == 1 and pushUp) or (global.grav == -1 and pushDown) {
    var overlapPlayer = place_meeting(x, y, objPlayer)
    
    carryPlayer = place_meeting(x, y - global.grav, objPlayer) and not overlapPlayer
    
    if carryPlayer carryPlayerOnTop = true
}

if solidType == objBlock {
    if not carryPlayer and hasVineLeft {
        carryPlayer = place_meeting(x - 1, y, objPlayer) and not overlapPlayer
    }
        
    if not carryPlayer and hasVineRight {
        carryPlayer = place_meeting(x + 1, y, objPlayer) and not overlapPlayer
    }
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
    
    var collided = place_meeting(x, y, objPlayer) and not place_meeting(x - dX, y, objPlayer)
    
    if collided {
        if dX > 0 and pushRight {
            var playerWidth = sprite_get_width(objPlayer.mask_index)
            var pushDX = x + sprite_width / 2 - (objPlayer.x - floor(playerWidth / 2))
            
            with objPlayer var squished = moveContactSolids(pushDX, 0)
            if squished scrKillPlayer()
            
            image_blend = c_lime
        }
        else if dX < 0 and pushLeft {
            var playerWidth = sprite_get_width(objPlayer.mask_index)
            var pushDX = x - sprite_width / 2 - (objPlayer.x + floor(playerWidth / 2)) - 1
            
            with objPlayer var squished = moveContactSolids(pushDX, 0)
            if squished scrKillPlayer()
            
            image_blend = c_lime
        }
    }
    else if carryPlayer and not (carryPlayerOnTop and objPlayer.carriedXOnTop) {
        if carryPlayerOnTop objPlayer.carriedXOnTop = true
        
        with objPlayer moveContactSolids(dX, 0)
        
        image_blend = c_aqua
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
            
            image_blend = c_lime
        }
        else if dY < 0 and pushUp {
            var playerHeight = sprite_get_height(objPlayer.mask_index)
            var pushDY = y - sprite_height / 2 - (objPlayer.y + floor(playerHeight / 2)) - 1
            
            with objPlayer var squished = moveContactSolids(0, pushDY)
            if squished scrKillPlayer()
            
            image_blend = c_lime
        }
    }
    else if carryPlayer {
        with objPlayer moveContactSolids(0, dY)
        
        image_blend = c_aqua
    }
}
