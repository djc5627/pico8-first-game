function _init()
    _init_stars()
    _init_enemy_spawner()
    score = 0
end

function _update()
    _update_stars()
    _update_player_dir()
    _move_player()
    _handle_player_collisions()
    _update_enemy_spawner()
end

function _draw()
    cls()
    rectfill(0, 0, 127, 127, 1)
    _draw_stars()
    _draw_player()
    _draw_enemy_spawner()

    print("score: "..global.score, 8, 8, 7)
end

