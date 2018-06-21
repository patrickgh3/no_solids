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


var playerPushBlockPixels = 2

for (var i = 0; i < abs(dX); i++) {
    var stepX = sign(dX)
    
    var pushableBlock = noone
    var pushedBlock = false
    
    if object_index == objPlayer and playerPushBlockPixels > 0 {
        pushableBlock = instance_place(x + stepX, y, objPushableBlock)
        
        with pushableBlock {
            if place_meeting(x, y + sign(yGravity), objBlock) {
                pushedBlock = not scrMoveContactBlocks(stepX, 0, false)
                
                playerPushBlockPixels--
            }
        }
    }

    if place_meeting(x + stepX, y, objBlock) or scrWouldPressOneWayWall(stepX, 0) != noone {
        if pushedBlock pushableBlock.x -= stepX
        break
    }
    
    x += stepX
}

for (var i = 0; i < abs(dY); i++) {
    var stepY = sign(dY)
    
    if (place_meeting(x, y + stepY, objBlock) or scrWouldPressOneWayWall(0, stepY) != noone) {
        break
    }
    
    y += stepY
}

return true
