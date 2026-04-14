Game = Object:extend()

local player
local enemies
local enemyBullets
local playerBullets
local counter

function Game:prepare()
    player = Player()
    enemies = {}
    enemyBullets = {}
    playerBullets = {}
    counter = 0

    table.insert(enemies, Enemy1())
    STATE = "playing"
end

function Game:update(dt)
    counter = counter + dt
    local newPlayerBullets = {}
    local newEnemyBullets = {}
    player:update(dt, newPlayerBullets)

    for i,v in ipairs(enemyBullets) do
        v:update(dt)
        if player:collided(v) then
            STATE = "menu"
        elseif v.gone then
            table.remove(enemyBullets, i)
        end
    end

    for i,v in ipairs(playerBullets) do
        v:update(dt)
        if v.gone then
            table.remove(playerBullets, i)
        else
            for j,w in ipairs(enemies) do
                if v:collided(w) then
                    table.remove(playerBullets, i)
                    table.remove(enemies, j)

                    -- spawn new enemies
                    -- otherwise the game would never end!
                    table.insert(enemies, Enemy1())
                    table.insert(enemies, Enemy1())
                end
            end
        end
    end

    for i,v in ipairs(enemies) do
        v:update(dt, newEnemyBullets)
        if player:collided(v) then
            STATE = "menu"
        elseif v.gone then
            table.remove(enemies, i)
            table.insert(enemies, Enemy1())
        end
    end

    for i,v in ipairs(newEnemyBullets) do
        v:target(player)
        table.insert(enemyBullets, v)
    end

    for i,v in ipairs(newPlayerBullets) do
        table.insert(playerBullets, v)
    end

    if counter > 5 then
        table.insert(enemies, Enemy1())
        counter = counter - 5
    end
end

function Game:draw()
    for i,v in ipairs(enemies) do
        v:draw()
    end
    for i,v in ipairs(enemyBullets) do
        v:draw()
    end
    for i,v in ipairs(playerBullets) do
        v:draw()
    end
    player:draw()
end
