enemies = {}

function _add_enemy(x, y, health, shoot_delay, hw, hh, si)
    add(enemies, {
        x=x,
        y=y,
        health=health,
        shoot_delay=shoot_delay,
        hw=hw, --hitbox width
        hh=hh, --hitbox height
        si=si,  --sprite index
        last_shoot_time=0
    })
end

function _update_enemies()
    for e in all(enemies) do
        -- Shooting
        if time() - e.last_shoot_time > e.shoot_delay then
            e.last_shoot_time = time()
            _add_bullet(enemy_bullets, e.x, e.y + 8, 0, 1, 3, 3, 5)
        end

        -- Collisions
        for b in all(player_bullets) do
            local collided = false
            collided = hit(
                b.x - b.hw/2,
                b.y - b.hh/2,
                b.hw,
                b.hh,
                e.x-e.hw,
                e.y-e.hh,
                e.hw,
                e.hh,
                b.x - b.hw/2 + b.spdx,
                b.y - b.hh/2 + b.spdy
            )
            if collided then
                del(player_bullets, b)
                e.health -= 1
            end
        end

        -- Death
        if e.health <= 0 then
            del(enemies, e)
            global.score += 1
            sfx(0)
        end
    end
end

function _draw_enemies()
    for e in all(enemies) do
        _draw_sprite(e.si, e.x, e.y)
            -- draw hitbox for debugging
            if global.debug then
                rect(e.x-e.hw/2, e.y-e.hh/2, e.x+e.hw/2, e.y+e.hh/2, 7)
                pset(e.x, e.y, 8)
            end
    end
end