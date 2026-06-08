playerSpeed = 2.0
playerDirX = 1
playerDirY = 1
playerPosX = 63
playerPosY = 63
storedMoveX = 0.0
storedMoveY = 0.0

function _updatePlayerDir()
    if btn(0) then
        playerDirX = -1
    elseif btn(1) then
        playerDirX = 1
    else
        playerDirX = 0
    end

    if btn(2) then
        playerDirY = 1
    elseif btn(3) then
        playerDirY = -1
    else
        playerDirY = 0
    end
end

function _movePlayer()
    -- normalize diagonal movement so speed is constant
    local dx = playerDirX * 1.0
    local dy = playerDirY * 1.0

    if dx ~= 0 and dy ~= 0 then
        -- when moving diagonally, divide by sqrt(2) to keep total speed equal
        -- sqrt(2) only works because the playerDirX and playerDirY are either -1, 0, or 1
        -- so the length of the vector (dx, dy) is always sqrt(2) when both are non-zero
        local inv = 1 / sqrt(2)
        dx = dx * inv
        dy = dy * inv
    end

    storedMoveX = storedMoveX + (dx * playerSpeed)
    storedMoveY = storedMoveY + (-dy * playerSpeed)

    playerPosX += flr(storedMoveX)
    playerPosY += flr(storedMoveY)

    storedMoveX = storedMoveX % 1
    storedMoveY = storedMoveY % 1
end