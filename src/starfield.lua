---@diagnostic disable: undefined-global
function _initStars()
    stars = {}
    star_types = {star, far_star, near_star}

    for i=1, 50 do
        local star_type = rnd(star_types)
        local star = star_type:new({
            x = flr(rnd(128)),
            y = flr(rnd(128)),
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