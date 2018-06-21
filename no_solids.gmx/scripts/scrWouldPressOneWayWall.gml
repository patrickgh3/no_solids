/// scrWouldPressOneWayWall(dX, dY)

var dX = argument0
var dY = argument1

if not place_meeting(x + dX, y + dY, objOneWayWall) return noone

with objOneWayWall {
    if not place_meeting(x, y, other)
            and ((blockRight and dX < 0) or (blockLeft and dX > 0))
            and place_meeting(x - dX, y, other) {
        return id
    }
}

return noone
