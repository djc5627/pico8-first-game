----- btn() values for given inputs
-- Note: Must bitwise &001111 to remove the x/o button bits
-- 0 - stop
-- 1 - left
-- 2 - right
-- 3 - l+r = stop
-- 4 - up
-- 5 - diag L/U
-- 6 - diag R/U
-- 7 - l+u+r = up
-- 8 - down
-- 9 - diag L/D
-- 10 - diag R/D
-- 11 - l+d+r = d
-- 12 - u+d = stop
-- 13 - l+u+d = left
-- 14 - r+u+d = r
-- 15 - l+u+r+d = stop

----- Output of our conversion
-- 0 - no buttons pressed
-- 1 - left
-- 2 - right
-- 3 - up
-- 4 - down

-- 5 - left/up
-- 6 - right/up
-- 7 - right/down
-- 8 - left/down

butarr={1,2,0,3,5,6,3,4,8,7,4,0,1,2,0}
butarr[0]=0
dirx={-1,1,0,0,-0.75,0.75,0.75,-0.75}
diry={0,0,-1,1,-0.75,-0.75,0.75,0.75}

playerSpeed = 1.4
playerWidth = 8
playerHeight = 8
playerShootDelay = 0.2
playerLastShootTime = 0
playerLastDir = 0


function _init_player()
    playerHealth = 3
    playerPosX = 63
    playerPosY = 63
    playerLastDir = 0
end

function _move_player()
    local dir = butarr[btn()&0b1111]

    if playerLastDir!=dir and dir>=5 then
        --Anti-cobblestone on diagonals
        playerPosX = flr(playerPosX) + 0.5
        playerPosY = flr(playerPosY) + 0.5
    end

    if dir > 0 then
        playerPosX += dirx[dir]*playerSpeed
        playerPosY += diry[dir]*playerSpeed
    end
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
    _move_player()
    _shoot()
    _handle_player_collisions()
    _handle_player_death()
end

function _draw_player()
    spr(0, playerPosX, playerPosY, 1, 1, false, false)
    print("health: "..playerHealth, 8, 12, 7)
end

function _handle_player_death()
    if playerHealth <= 0 then
        state = "game_over"
        sfx(2)
    end
end

function _handle_player_collisions()
    local t,nx,ny,tx,ty,intersect
    for bullet in all(bullets) do
        if not bullet.friendly then
            t,nx,ny,tx,ty,intersect = hit(
                bullet.x - bullet.rad,
                bullet.y - bullet.rad,
                bullet.rad * 2,
                bullet.rad * 2,
                playerPosX,
                playerPosY,
                playerWidth,
                playerHeight,
                bullet.x - bullet.rad + bullet.dirX * bullet.spd,
                bullet.y - bullet.rad + bullet.dirY * bullet.spd
            )
            if intersect then
                del(bullets, bullet)
                playerHealth -= 1
            end
        end
    end
end