playerSpeed = 2.0
playerWidth = 8
playerHeight = 8
playerDirX = 1
playerDirY = 1
playerPosX = 63
playerPosY = 63
storedMoveX = 0.0
storedMoveY = 0.0
playerShootDelay = 0.2
playerLastShootTime = 0

function _init_player()
    bullets = {}
end

function _update_player_dir()
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

function _move_player()
    -- normalize diagonal movement so speed is constant
    local dx = playerDirX * 1.0
    local dy = playerDirY * 1.0

    if dx ~= 0 and dy ~= 0 then
        -- when moving diagonally, divide by sqrt(2) to keep total speed equal
        -- sqrt(2) only works because the playerDirX and playerDirY are either -1, 0, or 1
        -- so the length of the vector (dx, dy) is always sqrt(2) when both are non-zero
        local inv = 1 / sqrt(2)
        dx *= inv
        dy *= inv
    end

    storedMoveX = storedMoveX + (dx * playerSpeed)
    storedMoveY = storedMoveY + (-dy * playerSpeed)

    playerPosX += flr(storedMoveX)
    playerPosY += flr(storedMoveY)

    storedMoveX = storedMoveX % 1
    storedMoveY = storedMoveY % 1
end

function _shoot()
    -- Only shoot if delay has passed since the last shot
    if btn(4) and time() - playerLastShootTime >= playerShootDelay then
        -- Create a new bullet.lua entity and add it to the bullets table
        local new_bullet = bullet:new({
            x = playerPosX + playerWidth / 2,
            y = playerPosY,
            dirX = 0,
            dirY = -1,
        })
        add(bullets, new_bullet)
        playerLastShootTime = time()
        sfx(1)
     end
end

function _update_player()
    _update_player_dir()
    _move_player()
    _shoot()
    _handle_player_collisions()

    -- Update bullets
    for bullet in all(bullets) do
        bullet:update()
    end
end

function _draw_player()
    spr(0, playerPosX, playerPosY, 1, 1, false, false)

    -- Draw bullets
    for bullet in all(bullets) do
        bullet:draw()
    end
end

function _handle_player_collisions()
    local t,nx,ny,tx,ty,intersect
    for star in all(stars) do
        t,nx,ny,tx,ty,intersect = hit(
            star.x - star.rad,
            star.y - star.rad,
            star.rad * 2,
            star.rad * 2,
            playerPosX,
            playerPosY,
            playerWidth,
            playerHeight,
            star.x,
            star.y
        )
    end
end