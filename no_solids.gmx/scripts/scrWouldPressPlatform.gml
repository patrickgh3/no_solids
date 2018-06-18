/// scrWouldPressPlatform(dY)

var dY = argument0

with objPlatform {
    with other {
        if place_meeting(x, y + dY, other) and not place_meeting(x, y, other) {
            return other.id
        }
    }
}

return noone
