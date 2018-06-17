///scrSetGrav(grav)
// grav should be 1 or -1

global.grav = argument0
with objPlayer {
    yGravity = abs(yGravity) * global.grav
}
