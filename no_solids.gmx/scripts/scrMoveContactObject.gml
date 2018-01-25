///scrMoveContactObject(dx, dy, obj)

var dx = argument0
var dy = argument1
var obj = argument2

if not place_meeting(x+dx, y+dy, obj) {
    x += dx
    y += dy
    return 1
}

if dx != 0 {
    var xx = 0
    while xx < abs(dx) and not place_meeting(x+sign(dx), y, obj) {
        x += sign(dx)
        xx ++
    }
}
if dy != 0 {
    var yy = 0
    while yy < abs(dy) and not place_meeting(x, y+sign(dy), obj) {
        y += sign(dy)
        yy ++
    }
}
