function _init_enemy_spawner()
    e_spawn_rate = 2 -- seconds between spawns
    last_enemy_spawn_time = time()
    max_enemies = 10
end

function _update_enemy_spawner()
    -- Check if it's time to spawn a new enemy
    if #enemies < max_enemies and
        time() - last_enemy_spawn_time >= e_spawn_rate then
        _add_enemy(
            flr(rnd(128)),
            flr(rnd(20)) + 20,
            10,
            3,
            14,
            14,
            3
        )
        last_enemy_spawn_time = time()
    end
end