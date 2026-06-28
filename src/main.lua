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
    _draw_stars()
    rectfill(0, 0, 127, 127, 1)
    circfill(playerPosX, playerPosY, 3, 4)
end

