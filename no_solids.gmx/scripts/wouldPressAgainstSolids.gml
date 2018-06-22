///wouldPressAgainstSolids(dX, dY)
// Returns true if a delta movement would result in pressing up against a solid, and false if it wouldn't.

var dX = argument0
var dY = argument1

return place_meeting(x + dX, y + dY, objBlock)
    or wouldPressAgainstOneWayWall(dX, dY)

/*
var xPrev = x
var yPrev = y

var pressed = moveContactSolids(dX, dY, true)

x = xPrev
y = yPrev

return pressed
