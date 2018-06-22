///moveContactSolidsOnlyIfPress(dX, dY)
// returns 0 if we didn't press up against a block/platform and we undid the movement,
// 1 if we did press and we didn't undo the movement

var dX = argument0
var dY = argument1


var xPrev = x
var yPrev = y

var pressed = moveContactSolids(dX, dY)

if not pressed {
    x = xPrev
    y = yPrev
}

return pressed
