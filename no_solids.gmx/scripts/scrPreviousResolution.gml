///scrPreviousResolution(setSize)
with objWorld {
    // Decrement and wrap
    global.resolution_index--
    if global.resolution_index < 0 {
        global.resolution_index = numres-1
    }
    // Decrement and wrap as long as resolution is larger than display
    for (var i=0; i<numres; i++) {
        if resw[global.resolution_index] >= display_get_width()
        or resh[global.resolution_index] >= display_get_height() {
            global.resolution_index--
            if global.resolution_index < 0 {
                global.resolution_index = numres-1
            }
        } else {
            break
        }
    }
    if argument0 {
        window_set_size(resw[global.resolution_index], resh[global.resolution_index])
        scrUpdateResolution()
    }
}
