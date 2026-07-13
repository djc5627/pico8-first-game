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
        _draw_sprite(3, x, y)

        -- draw hitbox for debugging
        if global.debug then
            rect(x, y, x+width, y+width, 7)
        end
        pset(x, y, 8)
    end,

    shoot = function(_ENV)
        if time() - last_shoot_time > shoot_delay then
            last_shoot_time = time()
            add(bullets, b)
            _add_bullet(enemy_bullets, x, y + 8, 0, 1, 3, 3, 5)
        end
    end,

    handle_collisions = function(_ENV)
        for b in all(player_bullets) do
            local collided = false
            collided = hit(
                b.x - b.hw/2,
                b.y - b.hh/2,
                b.hw,
                b.hh,
                x,
                y,
                width,
                width,
                b.x - b.hw/2 + b.spdx,
                b.y - b.hh/2 + b.spdy
            )
            if collided then
                del(player_bullets, b)
                health -= 1
            end
        end
    end
})