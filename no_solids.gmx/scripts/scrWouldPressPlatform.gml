/// scrWouldPressPlatform(dY)

var dY = argument0

if not place_meeting(x, y + dY, objPlatform) return noone

with objPlatform {
    with other {
        if place_meeting(x, y + dY, other) and not place_meeting(x, y, other) {
            return other.id
        }
    }
    /*if place_meeting(x, y - dY, other) and not place_meeting(x, y, other) {
        return id
    }*/
}

return noone
