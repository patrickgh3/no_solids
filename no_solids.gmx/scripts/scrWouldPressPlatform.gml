///scrWouldPressPlatform(dy)

var dy = argument0

for (var i = 0; i < instance_number(objPlatform); i++) {
    var platform = instance_find(objPlatform, i)
    
    if place_meeting(x, y + dy, platform) and not place_meeting(x, y, platform) {
        return platform
    }
}

return noone
