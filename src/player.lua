playerSpeed = 5
playerDirX = 1
playerDirY = 1
playerPosX = 63
playerPosY = 63

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
    -- TODO: Fix faster diagonals
    playerPosX = playerPosX + (playerDirX * playerSpeed)
    playerPosY = playerPosY + (-playerDirY * playerSpeed)
end