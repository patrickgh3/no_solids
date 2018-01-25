///scrSetGrav(grav)
// grav should be 1 or -1

global.grav = argument0
with objPlayer {
    jump = abs(jump) * global.grav
    jump2 = abs(jump2) * global.grav
    gravity = abs(gravity) * global.grav
}
