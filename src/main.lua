game_states = {"playing", "game_over"}
state = "playing"
debug = false


function _init()
    _init_player()
    _init_stars()
    _init_enemy_spawner()
    score = 0
    bullets = {}
end

function _update()
    -- Restart Game when over
    if state == "game_over" then
        if btnp(4) or btnp(5) then
            state = "playing"
            _init()
        end
        return
    else
        _update_stars()
        _update_player()
        _update_enemy_spawner()
        _update_bullets()
    end
end

function _draw()
    cls()

    if state == "game_over" then
        print("game over", 45, 40, 7)
        print("press o/x to restart", 25, 50, 7)
        return
    end

    rectfill(0, 0, 127, 127, 1)
    _draw_stars()
    _draw_player()
    _draw_enemy_spawner()
    _draw_bullets()

    print("score: "..score, 8, 4, 7)
end

