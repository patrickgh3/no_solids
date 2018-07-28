/// scrKillPlayer()

if not global.debugNoDeath {
    with objPlayer {
        instance_destroy()
    }
}
