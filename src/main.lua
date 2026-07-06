function _init()
    _init_player()
    _init_stars()
    _init_enemy_spawner()
    score = 0
end

function _update()
    _update_stars()
    _update_player()
    _update_enemy_spawner()
end

function _draw()
    cls()
    rectfill(0, 0, 127, 127, 1)
    _draw_stars()
    _draw_player()
    _draw_enemy_spawner()

    print("score: "..score, 8, 8, 7)
end

