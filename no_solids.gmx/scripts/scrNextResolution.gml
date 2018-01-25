///scrNextResolution(setSize)
with objWorld {
    // Increment and wrap
    global.resolution_index++
    if global.resolution_index >= numres {
        global.resolution_index = 0
    }
    // Increment and wrap as long as resolution is larger than display
    for (var i=0; i<numres; i++) {
        if resw[global.resolution_index] >= display_get_width()
        or resh[global.resolution_index] >= display_get_height() {
            global.resolution_index++
            if global.resolution_index >= numres {
                global.resolution_index = 0
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
