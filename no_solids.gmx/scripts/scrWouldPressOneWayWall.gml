/// scrWouldPressOneWayWall(dX, dY)

var dX = argument0
var dY = argument1

if not place_meeting(x + dX, y + dY, objOneWayWall) return noone

with objOneWayWall {
    if place_meeting(x, y, other) continue
    
    // We have to use "with other" for vertical collisions, I guess because
    // the player can have a fractional Y coordinate. There's weird behavior otherwise.
    // I'm not sure exactly what's going on with that.
    if (wallUp and dY > 0) or (wallDown and dY < 0)
    or (sign(dY) == global.grav and wallGravityDir) {
        with other {
            if place_meeting(x, y + dY, other) {
                return other.id
            }
        }
    }
    
    /*
    if ((wallUp and dY > 0) or (wallDown and dY < 0))
            and place_meeting(x, y - dY, other) {
        return id
    }
    */
    
    if ((wallLeft and dX > 0) or (wallRight and dX < 0))
            and place_meeting(x - dX, y, other) {
        return id
    }
}

return noone
