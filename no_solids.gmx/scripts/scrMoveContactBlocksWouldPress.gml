///scrMoveContactBlocksWouldPress(dx, dy)
// returns 0 if we wouldn't press up against a block/platform, 1 if we would

var dx = argument0
var dy = argument1


var xPrev = x
var yPrev = y

var pressed = scrMoveContactBlocks(dx, dy)

x = xPrev
y = yPrev

return pressed
