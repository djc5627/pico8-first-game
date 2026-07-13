--- TODO
-- [] Smooth out cardinal direction movement
-- [] Banking
-- [] Enemy types (straight, zig-zag, homing)
  -- [] Enemy movement defined by speed and angle

--- Working
-- [] Better Art
  -- [] Bigger 16x16 entity sprites
  -- [] More readable bullet with outline
  -- [] Implement support for 16x16 sprites
  -- [] Implement sprite animations

--- Done
-- [X] Move to new input system
-- [X] Fix cobblestoning on player (enemies too?)
-- [X] Normalize diagonals movement
-- [X] Move code to update60 for 60fps (adjust speeds)
-- [X] Pick a good movement speed
-- [X] Rename vars to match casing conventions
-- [X] Minimize hit.lua to ignore hit direction

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

function _update60()
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

    if debug then
        print(btn(), 8, 128-8*3, 7)
        print(btn()&0b1111, 8, 128-8*2, 7)
        print(butarr[btn()&0b1111], 8, 128-8*1, 7)
    end
end

