with objWorld {
    global.fullscreenMode = not global.fullscreenMode
    window_set_fullscreen(global.fullscreenMode)
    alarm[2] = 1
}
