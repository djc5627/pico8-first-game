bullet = entity:new({
    spd = 3,
    dirX = 0,
    dirY = -1,
    rad = 1,

    update = function(_ENV)
        x += spd * dirX
        y += spd * dirY
    end,

    draw = function(_ENV)
        circfill(x,y,rad,10)
    end
})