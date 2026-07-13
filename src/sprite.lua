-- Keeps track of Sprite table and offers
-- methods to interpret sprites

--[[
{
    {sprite_index, width, height, mirrorx, mirrory},
    ...
}
--]]

sprites = {
    {0, 2, 2, false, false}, -- 1) Player
    {2, 2, 2, false, false}, -- 2) Enemy1
    {5, 2, 2, false, false} -- 3) Enemy2
}

function _draw_sprite(index, x, y)
    -- Todo handle mirrorx, mirrory
    local sprite = sprites[index]
    spr(
        sprite[1],
        x,
        y,
        sprite[2],
        sprite[3],
        sprite[4],
        sprite[5]
    )
end