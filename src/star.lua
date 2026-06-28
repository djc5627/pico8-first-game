star = {
    x = 64,
    y = -1,
    spd = 1,
    rad = 1,
    clr = 7,

    update = function(self)
        self.y += self.spd
        if self.y > 127 then
            self.y = -self.rad
        end
    end,

    draw = function(self)
        circfill(self.x, self.y, self.rad, self.clr)
    end
}