-- Keeps track of Sprite table and offers
-- methods to interpret sprites

--[[
{
    {sprite_sheetx, sprite_sheety, width, height, mirrorx, offsetx, offsety},
    ...
}
--]]

sprites = {
    {0, 0, 8, 16, true}, -- 1) Player
    {8, 0, 8, 16, true}, -- 2) Enemy1
    {16, 0, 8, 16, true} -- 3) Enemy2
}

function _draw_sprite(index, x, y)
    local sprite = sprites[index]

    sspr(
        sprite[1],
        sprite[2],
        sprite[3],
        sprite[4],
        x,
        y,
        sprite[3],
        sprite[4],
        false,
        false
    )

    -- mirrorx
    if sprite[4] then
        sspr(
                sprite[1],
                sprite[2],
                sprite[3],
                sprite[4],
                x + sprite[3],
                y,
                sprite[3],
                sprite[4],
                true,
                false
            )
    end
end