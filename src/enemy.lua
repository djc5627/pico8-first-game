enemy = entity:new({
    health = 3,
    width = 8,
    shootDelay = 3,
    lastShootTime = 0,

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
        if time() - lastShootTime > shootDelay then
            lastShootTime = time()
            local b = enmy_bullet:new({
                x = x + width/2,
                y = y + width,
                dirX = 0,
                dirY = 1
            })
            add(bullets, b)
        end
    end,

    handle_collisions = function(_ENV)
        local t,nx,ny,tx,ty,intersect
        for bullet in all(bullets) do
            if bullet.friendly then
                t,nx,ny,tx,ty,intersect = hit(
                    bullet.x - bullet.rad,
                    bullet.y - bullet.rad,
                    bullet.rad * 2,
                    bullet.rad * 2,
                    x,
                    y,
                    width,
                    width,
                    bullet.x - bullet.rad + bullet.dirX * bullet.spd,
                    bullet.y - bullet.rad + bullet.dirY * bullet.spd
                )
                if intersect == true or intersect == false then
                    del(bullets, bullet)
                    health -= 1
                end
            end
        end
    end
})