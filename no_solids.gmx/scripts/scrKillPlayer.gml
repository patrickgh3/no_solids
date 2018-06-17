/// scrKillPlayer()

if not (global.debugMode and global.debugNoDeath) {
    with objPlayer {
        instance_destroy()
    }
}
