function _init()

end

function _update()
    _updatePlayerDir()
    _movePlayer()
end

function _draw()
    cls()
    circfill(playerPosX, playerPosY, 3, 4)
end

