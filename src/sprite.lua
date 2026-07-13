-- Keeps track of Sprite table and offers
-- methods to interpret sprites

--[[
{
    {sprite_index, width, height, mirrorx},
    ...
}
--]]

sprites = {
    {0, 1, 2, true}, -- 1) Player
    {1, 1, 2, true}, -- 2) Enemy1
    {2, 1, 2, true} -- 3) Enemy2
}

function _draw_sprite(index, x, y)
    local sprite = sprites[index]

    spr(
        sprite[1],
        x,
        y,
        sprite[2],
        sprite[3],
        false,
        false
    )

    -- mirrorx
    if sprite[4] then
        spr(
            sprite[1],
            x + sprite[2]*8,
            y,
            sprite[2],
            sprite[3],
            true,
            false
        )
    end
end