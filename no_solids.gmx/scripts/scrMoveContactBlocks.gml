///scrMoveContactBlocks(dX, dY, stopOnPlatforms)
// returns 0 if we didn't press up against a block/platform, 1 if we did

var dX = argument0
var dY = argument1
var stopOnPlatforms = argument2

if dX == 0 and dY == 0 {
    return false
}

if not place_meeting(x + dX, y + dY, objBlock)
and not (sign(dY) == global.grav and scrWouldPressPlatform(dY) != noone) {
    x += dX
    y += dY
    
    return false
}


var playerPushBlockPixels = 2

for (var i = 0; i < abs(dX); i++) {
    if object_index == objPlayer and playerPushBlockPixels > 0 {
        with instance_place(x + sign(dX), y, objPushableBlock) {
            if place_meeting(x, y + sign(yGravity), objBlock) {
                scrMoveContactBlocks(sign(dX), 0, false)
                
                playerPushBlockPixels--
            }
        }
    }

    if place_meeting(x + sign(dX), y, objBlock) {
        break
    }
    
    x += sign(dX)
}

for (var i = 0; i < abs(dY); i++) {
    if (place_meeting(x, y + sign(dY), objBlock)
        or (stopOnPlatforms and sign(dY) == global.grav and scrWouldPressPlatform(sign(dY)) != noone)) {
        break
    }
    
    y += sign(dY)
}

return true
