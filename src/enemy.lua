enemy = entity:new({
    health = 3,
    width = 8,
    shoot_delay = 3,
    last_shoot_time = 0,

    update = function(_ENV)
        handle_collisions(_ENV)
        shoot(_ENV)
    end,

    draw = function(_ENV)
        -- rectfill(x, y, x+8, y+8, 8)
        spr(1, x, y, 1, 1, false, false)

        -- draw hitbox for debugging
        if global.debug then
            rect(x, y, x+width, y+width, 7)
        end
    end,

    shoot = function(_ENV)
        if time() - last_shoot_time > shoot_delay then
            last_shoot_time = time()
            local b = enmy_bullet:new({
                x = x + width/2,
                y = y + width,
                dirx = 0,
                diry = 1
            })
            add(bullets, b)
        end
    end,

    handle_collisions = function(_ENV)
        for bullet in all(bullets) do
            local collided = false
            if bullet.friendly then
                collided = hit(
                    bullet.x - bullet.rad,
                    bullet.y - bullet.rad,
                    bullet.rad * 2,
                    bullet.rad * 2,
                    x,
                    y,
                    width,
                    width,
                    bullet.x - bullet.rad + bullet.dirx * bullet.spd,
                    bullet.y - bullet.rad + bullet.diry * bullet.spd
                )
                if collided then
                    del(bullets, bullet)
                    health -= 1
                end
            end
        end
    end
})