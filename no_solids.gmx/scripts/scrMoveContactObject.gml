///scrMoveContactObject(dx, dy, obj)
// returns 0 if didn't press, 1 if did press

var dx = argument0
var dy = argument1
var obj = argument2


if not place_meeting(x + dx, y + dy, obj)
and not (sign(dy) == global.grav and scrWouldPressPlatform(dy) != noone) {
    x += dx
    y += dy
    
    return false
}


var pressed = false

if dx != 0 {
    var xx = 0
    while xx < abs(dx) and not place_meeting(x + sign(dx), y, obj) {
        x += sign(dx)
        xx ++
    }
    
    pressed = true
}

if dy != 0 {
    var yy = 0
    while yy < abs(dy)
        and not (place_meeting(x, y + sign(dy), obj)
        or (sign(dy) == global.grav and scrWouldPressPlatform(sign(dy)) != noone)) {
        
        y += sign(dy)
        yy ++
    }
    
    pressed = true
}

return pressed
