/// snapOnTopOfOneWay(oneWayWallObj)

var oneWayWallObj = argument0

var height = sprite_get_height(mask_index)
        
if global.grav == 1 {
    y = oneWayWallObj.bbox_top - ceil(height / 2)
} else {
    y = oneWayWallObj.bbox_bottom + ceil(height / 2)
}

ySpeed = 0
