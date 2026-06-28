function _init()
    _initStars()
end

function _update()
    _update_stars()
    _update_player_dir()
    _move_player()
end

function _draw()
    cls()
    rectfill(0, 0, 127, 127, 1)
    _draw_stars()
    circfill(playerPosX, playerPosY, 3, 4)
end

