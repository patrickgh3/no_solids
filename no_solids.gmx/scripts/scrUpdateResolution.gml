/// Update port, view, and application_surface based on the resolution
with objWorld {
    if window_get_fullscreen() {
        view_wport[0] = window_get_width()
        view_hport[0] = window_get_height()
    } else {
        view_wport[0] = resw[global.resolution_index]
        view_hport[0] = resh[global.resolution_index]
        alarm[4] = 1
    }
    
    if view_hport[0] >= 900 {
        scale = 2
    }
    else scale = 1
    view_wview[0] = view_wport[0]/scale
    view_hview[0] = view_hport[0]/scale
    surface_resize(application_surface, view_wview[0],view_hview[0])
}
