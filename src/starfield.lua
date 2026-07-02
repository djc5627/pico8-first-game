---@diagnostic disable: undefined-global
function _initStars()
    stars = {}

    for i=1, 50 do
        local star = star:new({
            x = flr(rnd(128)),
            y = flr(rnd(128)),
            -- spd = rnd(10) + 0.5,
            spd = rnd(.25) + 0.1,
            rad = flr(rnd(2)),
            clr = 7
        })
        add(stars, star)
    end
end

function _update_stars()
    for star in all(stars) do
        star:update()
    end
end

function _draw_stars()
    for star in all(stars) do
        star:draw()
    end
end