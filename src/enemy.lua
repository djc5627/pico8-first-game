enemy = entity:new({
    health = 3,
    width = 8,

    update = function(_ENV)
        handle_collisions(_ENV)
    end,

    draw = function(_ENV)
        -- rectfill(x, y, x+8, y+8, 8)
        spr(1, x, y, 1, 1, false, false)
    end,

    handle_collisions = function(_ENV)
        local t,nx,ny,tx,ty,intersect
        for bullet in all(bullets) do
            t,nx,ny,tx,ty,intersect = hit(
                bullet.x - bullet.rad,
                bullet.y - bullet.rad,
                bullet.rad * 2,
                bullet.rad * 2,
                x,
                y,
                width,
                width,
                bullet.x - bullet.rad,
                bullet.y - bullet.rad
            )
            if intersect then
                del(bullets, bullet)
                health -= 1
            end
        end
    end
})