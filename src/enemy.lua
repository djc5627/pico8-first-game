enemy = entity:new({
    health = 3,

    update = function(_ENV)
        if health <= 0 then
            del(enemy_spawner.enemies, self)
        end
    end,

    draw = function(_ENV)
        -- rectfill(x, y, x+8, y+8, 8)
        spr(1, x, y, 8, 8, false, false)
    end
})