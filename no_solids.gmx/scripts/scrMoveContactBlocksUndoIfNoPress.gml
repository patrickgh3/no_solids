///scrMoveContactBlocksUndoIfNoPress(dx, dy)
// returns 0 if we didn't press up against a block/platform and we undid the movement,
// 1 if we did press and we didn't undo the movement

var dx = argument0
var dy = argument1


var xPrev = x
var yPrev = y

var pressed = scrMoveContactBlocks(dx, dy, true)

if not pressed {
    x = xPrev
    y = yPrev
}

return pressed
