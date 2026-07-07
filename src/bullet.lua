bullet = entity:new({
    spd = 3,
    dirX = 0,
    dirY = -1,
    rad = 1,
    clr = 10,
    friendly = true,

    update = function(_ENV)
        x += spd * dirX
        y += spd * dirY
    end,

    draw = function(_ENV)
        circfill(x,y,rad,clr)
    end
})

enmy_bullet = bullet:new({
    friendly = false,
    clr = 8,
    dirY = 1
})

function _update_bullets()
    for bullet in all(bullets) do
        bullet:update()
        if bullet.y < -bullet.rad or bullet.y > 128 + bullet.rad then
            del(bullets, bullet)
        end
    end
end

function _draw_bullets()
    for bullet in all(bullets) do
        bullet:draw()
        -- draw hitbox for debugging
        if global.debug then
            rect(bullet.x - bullet.rad, bullet.y - bullet.rad, bullet.x + bullet.rad, bullet.y + bullet.rad, 7)
        end
    end
end