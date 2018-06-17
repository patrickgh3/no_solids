///scrMoveContactObject(dx, dy, obj)

var dx = argument0
var dy = argument1
var obj = argument2


var xPrev = x
var yPrev = y

var pressed = scrMoveContactObject(dx, dy, obj)

x = xPrev
y = yPrev

return pressed
