--- TODO
-- [] Smooth out cardinal direction movement
-- [] Banking
-- [] Enemy types (straight, zig-zag, homing)
  -- [] Enemy movement defined by speed and angle
-- [] Standardize hitbox editor
-- [] Implement sprite animations
-- [] Standardize method and var naming conventions


--- Working

--- Done
-- [X] Move to new input system
-- [X] Fix cobblestoning on player (enemies too?)
-- [X] Normalize diagonals movement
-- [X] Move code to update60 for 60fps (adjust speeds)
-- [X] Pick a good movement speed
-- [X] Rename vars to match casing conventions
-- [X] Minimize hit.lua to ignore hit direction
-- [X] Better Art
  -- [X] Bigger 16x16 entity sprites
  -- [X] Implement support for 16x16 sprites
  -- [X] Support for mirror sprites in the X axis
  -- [X] More readable bullet with outline
-- [X] Separate player/enemy bullets
  -- [X] Unique sprites
  -- [X] Unique hitboxes
-- [X] Center player hitbox
-- [X] Center enemy hitbox

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
        _update_enemies()
        _update_bullets(player_bullets)
        _update_bullets(enemy_bullets)
    end
end

function _draw()
    cls()

    if state == "game_over" then
        print("game over", 45, 40, 7)
        print("press o/x to restart", 25, 50, 7)
        return
    end

    ----- Draw background
    rectfill(0, 0, 127, 127, 1)

    ----- Draw Sprites
    -- Set blue as transparent
    palt(0, false)
    palt(1, true)

    _draw_stars()
    _draw_player()
    _draw_enemies()
    _draw_bullets(player_bullets)
    _draw_bullets(enemy_bullets)

    -- Set black as transparent
    palt(0, true)
    palt(1, false)

    print("score: "..score, 8, 4, 7)

    if debug then
        print(btn(), 8, 128-8*3, 7)
        print(btn()&0b1111, 8, 128-8*2, 7)
        print(butarr[btn()&0b1111], 8, 128-8*1, 7)
    end
end

