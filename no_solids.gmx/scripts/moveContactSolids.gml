/// moveContactSolids(dX, dY)
// Moves an object by a delta X and Y, pressing up against any solids in the way instead of passing through them.
// Returns true if we did press up against a solid, and false if we didn't.

// This script mimics the behavior of move_contact_solid.
// If no solid is in the way, we move by the full deltas.
// If there is one in the way, we move pixel-by-pixel up against it; no fractional pixels.

var dX = argument0
var dY = argument1

if dX == 0 and dY == 0 {
    return false
}

// Fangame engine movement performs this check, which allows dying when walking off a block
// onto a spike with a bad align.
// This check also allows objects which are overlapping blocks to "escape".
/*
if not place_meeting(x + dX, y + dY, objBlock)
and wouldPressAgainstOneWayWall(dX, dY) == noone {
    x += dX
    y += dY
    
    return false
}
*/


var playerPushBlockPixels = 2

for (var i = 0; i < abs(dX); i++) {
    var stepX = sign(dX)
    
    /*
    var pushableBlock = noone
    var pushedBlock = false
    
    if object_index == objPlayer and playerPushBlockPixels > 0 {
        pushableBlock = instance_place(x + stepX, y, objPushableBlock)
        
        with pushableBlock {
            if place_meeting(x, y + sign(yGravity), objBlock) {
                pushedBlock = not moveContactSolids(stepX, 0)
                
                playerPushBlockPixels--
            }
        }
    }

    if place_meeting(x + stepX, y, objBlock) or wouldPressAgainstOneWayWall(stepX, 0) != noone {
        if pushedBlock pushableBlock.x -= stepX
        break
    }
    */
    
    if object_index == objPushableBlock {
        show_debug_message('push block move')
        solidMove(stepX, 0)
    } else {
        x += stepX
    }
}

for (var i = 0; i < abs(dY); i++) {
    var stepY = sign(dY)
    
    if (place_meeting(x, y + stepY, objBlock) or wouldPressAgainstOneWayWall(0, stepY) != noone) {
        break
    }
    
    y += stepY
}

return true
