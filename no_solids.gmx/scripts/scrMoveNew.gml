/// scrMoveNew(dX, dY, carryPlayer, stopAtBlocks, pushUpOnly)

var dX = argument0
var dY = argument1
var carryPlayer = argument2
var stopAtBlocks = argument3
var pushUpOnly = argument4

if dX == 0 and dY == 0 {
    return 0
}

var xPrev = x
var yPrev = y

var pushLeft = true
var pushRight = true
var pushUp = true
var pushDown = true

if pushUpOnly {
    pushLeft = false
    pushRight = false
    if global.grav == 1 pushDown = false
    else pushUp = false
}

var playerRiding = noone

if carryPlayer {
    // Multiplying global.grav by this scalar is a hack to fix "popping off" riding blocks that accelerate downwards
    playerRiding = instance_place(x, y - global.grav * 1.5, objPlayer)
    
    // Vine riding behind a moving block
    if vinesEnabled and playerRiding == noone {
        // This number is kinda hacky, I'm not sure how big/small it needs to be, but this works...
        var vineRideRange = 2
        
        playerRiding = instance_place(x - vineRideRange, y, objPlayer)
        
        if playerRiding == noone {
            playerRiding = instance_place(x + vineRideRange, y, objPlayer)
        }
    }
    
    if place_meeting(x, y, playerRiding) {
        playerRiding = noone
    }
}

if stopAtBlocks
and not place_meeting(x + dX, y + dY, objBlock)
and not (sign(dY) == global.grav and scrWouldPressPlatform(dY) != noone) {
    x += dX
    y += dY
    
    with playerRiding scrMoveNew(dX, dY, false, true, false)
    
    return false
}

var pressed = false

for (var i = 0; i < abs(dX); i++) {

    with instance_place(x + sign(dX), y, objPushableBlock) {
        // The player can only push pushable blocks when they're on the ground, not midair
        if other.object_index == objPlayer
        and (place_meeting(x, y + sign(yGravity), objBlock)
        or place_meeting(x, y + sign(yGravity), objPlatform)) {
            
            scrMoveNew(sign(dX), 0, true, true, false)
        }
    }
    
    if stopAtBlocks and place_meeting(x + sign(dX), y, objBlock) {
        pressed = true
        break
    }
    
    x += sign(dX)
    
    // todo: disable multiple blocks moving the player in the same step
    with playerRiding {
        scrMoveNew(sign(dX), 0, false, true, false)
        other.image_blend = c_aqua
    }
}

var collided = instance_place(x, y, objPlayer)
if collided != noone and not place_meeting(xPrev, y, objPlayer) {
//if collided != noone {
    if dX > 0 and pushRight {
        collided.x += bbox_right + 1 - collided.bbox_left
        collided.x = ceil(collided.x) // hack to prevent weird stuck behavior on blocks moving at 0.5 speed
        
        image_blend = c_lime
    }
    else if dX < 0 and pushLeft {
        collided.x += bbox_left - (collided.bbox_right + 1)
        collided.x = floor(collided.x) // hack to prevent weird stuck behavior on blocks moving at 0.5 speed
        
        image_blend = c_lime
    }
}

for (var i = 0; i < abs(dY); i++) {
    if stopAtBlocks and 
    (place_meeting(x, y + sign(dY), objBlock)
    or (sign(dY) == global.grav and scrWouldPressPlatform(sign(dY)) != noone)) {
        pressed = true
        break
    }
    
    y += sign(dY)
    
    with playerRiding {
        scrMoveNew(0, sign(dY), false, true, false)
        other.image_blend = c_aqua
    }
}

collided = instance_place(x, y, objPlayer)
if collided != noone and not place_meeting(x, yPrev, objPlayer) {
//if collided != noone {
    // Push down
    if dY > 0 and pushDown {
        collided.y += bbox_bottom + 1 - collided.bbox_top
        
        image_blend = c_lime
    }
    // Push up
    else if dY < 0 and pushUp {
        collided.y += bbox_top - (collided.bbox_bottom + 1)
        
        image_blend = c_lime
    }
}

return pressed
