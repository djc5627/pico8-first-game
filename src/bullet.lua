player_bullets = {}
enemy_bullets = {}

function _add_bullet(table, x, y, spdx, spdy, hw, hh, si)
    add(table, {
        x=x,
        y=y,
        spdx=spdx,
        spdy=spdy,
        hw=hw, --hitbox width
        hh=hh, --hitbox height
        si=si  --sprite index
    })
end

function _update_bullets(table)
    for s in all(table) do
        s.x += s.spdx
        s.y += s.spdy
        --todo update animation here

        if s.y<-16 or s.y > 136 then
            del(table,s)
        end
    end
end

function _draw_bullets(table)
    for b in all(table) do
        _draw_sprite(b.si, b.x, b.y)
        if debug then
            pset(b.x, b.y, 8)
            rect(b.x-b.hw/2, b.y-b.hh/2, b.x+b.hw/2, b.y+b.hh/2, 7)
        end
    end
end