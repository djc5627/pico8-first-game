star = entity:new({
    spd = .5,
    rad = 0,
    clr = 13,

    new = function(self, tbl)
        tbl = tbl or {}
        setmetatable(tbl, {
            __index=self
        })
        return tbl
    end,

    update = function(self)
        self.y += self.spd
        if self.y > 127 then
            self.y = -self.rad
        end
    end,

    draw = function(self)
        circfill(
            self.x,
            self.y,
            self.rad,
            self.clr
        )
    end
})

far_star = star:new({
    spd = 0.5,
    rad = 0,
    clr = 5
})

near_star = star:new({
    spd = .74,
    rad = 1,
    clr = 7,

    new = function(self, tbl)
        tbl = star.new(self, tbl)
        tbl.spd += rnd(.5)
        return tbl
    end
})