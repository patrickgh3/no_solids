///scrMoveContactBlocks(dx, dy)
// returns 0 if we didn't press up against a block/platform, 1 if we did

var dx = argument0
var dy = argument1


if not place_meeting(x + dx, y + dy, objBlock)
and not (sign(dy) == global.grav and scrWouldPressPlatform(dy) != noone) {
    x += dx
    y += dy
    
    return false
}


var pressed = false

if dx != 0 {
    var xx = 0
    while xx < abs(dx) and not place_meeting(x + sign(dx), y, objBlock) {
        x += sign(dx)
        xx ++
    }
    
    pressed = true
}

if dy != 0 {
    var yy = 0
    while yy < abs(dy)
        and not (place_meeting(x, y + sign(dy), objBlock)
        or (sign(dy) == global.grav and scrWouldPressPlatform(sign(dy)) != noone)) {
        
        y += sign(dy)
        yy ++
    }
    
    pressed = true
}

return pressed
