----- btn() values for given inputs
-- Note: Must bitwise &001111 to remove the x/o button bits
-- 0 - stop
-- 1 - left
-- 2 - right
-- 3 - l+r = stop
-- 4 - up
-- 5 - diag L/U
-- 6 - diag R/U
-- 7 - l+u+r = up
-- 8 - down
-- 9 - diag L/D
-- 10 - diag R/D
-- 11 - l+d+r = d
-- 12 - u+d = stop
-- 13 - l+u+d = left
-- 14 - r+u+d = r
-- 15 - l+u+r+d = stop

----- Output of our conversion
-- 0 - no buttons pressed
-- 1 - left
-- 2 - right
-- 3 - up
-- 4 - down

-- 5 - left/up
-- 6 - right/up
-- 7 - right/down
-- 8 - left/down

butarr={1,2,0,3,5,6,3,4,8,7,4,0,1,2,0}
butarr[0]=0
dirx={-1,1,0,0,-0.75,0.75,0.75,-0.75}
diry={0,0,-1,1,-0.75,-0.75,0.75,0.75}

p_speed = 1.4
p_width = 8
p_height = 8
p_shoot_delay = 0.2
p_last_shoot_time = 0
p_last_dir = 0


function _init_player()
    p_health = 3
    p_x = 63
    p_y = 63
    p_last_dir = 0
end

function _move_player()
    -- Bitwise & to strip out the o/x inputs
    local dir = butarr[btn()&0b1111]

    if p_last_dir!=dir and dir>=5 then
        --Anti-cobblestone on diagonals
        p_x = flr(p_x) + 0.5
        p_y = flr(p_y) + 0.5
    end

    if dir > 0 then
        p_x += dirx[dir]*p_speed
        p_y += diry[dir]*p_speed
    end
end

function _shoot()
    -- Only shoot if delay has passed since the last shot
    if btn(4) and time() - p_last_shoot_time >= p_shoot_delay then
        -- Create a new bullet.lua entity and add it to the bullets table
        local new_bullet = bullet:new({
            x = p_x + p_width / 2,
            y = p_y,
            dirx = 0,
            diry = -1,
        })
        add(bullets, new_bullet)
        p_last_shoot_time = time()
        sfx(1)
     end
end

function _update_player()
    _move_player()
    _shoot()
    _handle_player_collisions()
    _handle_player_death()
end

function _draw_player()
    _draw_sprite(1, p_x, p_y)
    print("health: "..p_health, 8, 12, 7)
end

function _handle_player_death()
    if p_health <= 0 then
        state = "game_over"
        sfx(2)
    end
end

function _handle_player_collisions()
    for bullet in all(bullets) do
        local collided = false
        if not bullet.friendly then
            collided = hit(
                bullet.x - bullet.rad,
                bullet.y - bullet.rad,
                bullet.rad * 2,
                bullet.rad * 2,
                p_x,
                p_y,
                p_width,
                p_height,
                bullet.x - bullet.rad + bullet.dirx * bullet.spd,
                bullet.y - bullet.rad + bullet.diry * bullet.spd
            )
            if collided then
                del(bullets, bullet)
                p_health -= 1
            end
        end
    end
end