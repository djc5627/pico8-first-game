bullet = entity:new({
    spd = 1.4,
    dirx = 0,
    diry = -1,
    rad = 1,
    clr = 10,
    friendly = true,

    update = function(_ENV)
        x += spd * dirx
        y += spd * diry
    end,

    draw = function(_ENV)
        if friendly then
            _draw_sprite(2, x, y)
        else
            circfill(x,y,rad,clr)
        end
    end
})

enmy_bullet = bullet:new({
    friendly = false,
    clr = 8,
    diry = 1
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