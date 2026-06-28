function _initStars()
    stars = {star}
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