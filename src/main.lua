function _init()
    _initStars()
    score = 0
end

function _update()
    _update_stars()
    _update_player_dir()
    _move_player()
    _handle_collisions()
end

function _draw()
    cls()
    rectfill(0, 0, 127, 127, 1)
    _draw_stars()
    _draw_player()

    print("score: "..global.score, 8, 8, 7)
end

