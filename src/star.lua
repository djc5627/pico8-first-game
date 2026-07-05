star = entity:new({
    spd = .5,
    rad = 0,
    clr = 13,

    update = function(_ENV)
        y += spd
        if y > 127 then
            y = -rad
            global.score += 1
        end
    end,

    draw = function(_ENV)
        circfill(x,y,rad,clr)
    end
})

far_star = star:new({
    spd = 0.5,
    rad = 0,
    clr = 5
})

near_star = star:new({
    spd = .74,
    rad = 0,
    clr = 7,

    new = function(self, tbl)
        tbl = star.new(self, tbl)
        tbl.spd += rnd(.5)
        return tbl
    end
})