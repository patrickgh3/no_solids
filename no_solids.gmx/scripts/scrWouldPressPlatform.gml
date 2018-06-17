/// scrWouldPressPlatform(dy)

var dy = argument0

with objPlatform {
    with other {
        if place_meeting(x, y + dy, other) and not place_meeting(x, y, other) {
            return other.id
        }
    }
}

return noone
