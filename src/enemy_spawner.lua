function _init_enemy_spawner()
    -- Initialize enemy spawner properties
    enemy_spawner = {
        spawn_rate = 2, -- seconds between spawns
        last_spawn_time = 0,
        enemies = {}
    }
end

function _update_enemy_spawner()
    -- Check if it's time to spawn a new enemy
    if time() - enemy_spawner.last_spawn_time >= enemy_spawner.spawn_rate then
        local new_enemy = enemy:new({
            x = flr(rnd(128)),
            y = flr(rnd(20)),
        })
        add(enemy_spawner.enemies, new_enemy)
        enemy_spawner.last_spawn_time = time()
    end

    -- Update existing enemies
    for enemy in all(enemy_spawner.enemies) do
        enemy:update()

        if enemy.health <= 0 then
            del(enemy_spawner.enemies, enemy)
            global.score += 1
        end
    end
end

function _draw_enemy_spawner()
    -- Draw all enemies
    for enemy in all(enemy_spawner.enemies) do
        enemy:draw()
    end
end