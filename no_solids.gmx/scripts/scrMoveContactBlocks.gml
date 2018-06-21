///scrMoveContactBlocks(dX, dY, stopOnPlatforms)
// returns 0 if we didn't press up against a block/platform, 1 if we did

var dX = argument0
var dY = argument1
var stopOnPlatforms = argument2

if dX == 0 and dY == 0 {
    return false
}

if not place_meeting(x + dX, y + dY, objBlock)
and scrWouldPressOneWayWall(dX, dY) == noone {
    x += dX
    y += dY
    
    return false
}


//var playerPushBlockPixels = 2

for (var i = 0; i < abs(dX); i++) {
    /*
    if object_index == objPlayer and playerPushBlockPixels > 0 {
        with instance_place(x + sign(dX), y, objPushableBlock) {
            if place_meeting(x, y + sign(yGravity), objBlock) {
                scrMoveContactBlocks(sign(dX), 0, false)
                
                playerPushBlockPixels--
            }
        }
    }
    */
    
    var stepX = sign(dX)

    if place_meeting(x + stepX, y, objBlock) 
        or scrWouldPressOneWayWall(stepX, 0) != noone {
        break
    }
    
    x += stepX
}

for (var i = 0; i < abs(dY); i++) {
    var stepY = sign(dY)
    
    if (place_meeting(x, y + stepY, objBlock)
        or scrWouldPressOneWayWall(0, stepY) != noone) {
        break
    }
    
    y += stepY
}

return true
