Game = Object:extend()

local player
local enemies
local enemyBullets
local counter

function Game:prepare()
    player = Player()
    enemies = {}
    enemyBullets = {}
    counter = 0

    table.insert(enemies, Enemy1())
    STATE = "playing"
end

function Game:update(dt)
    counter = counter + dt
    player:update(dt)

    for i,v in ipairs(enemyBullets) do
        v:update(dt)
        if player:collided(v) then
            STATE = "menu"
        elseif v.gone then
            table.remove(enemyBullets, i)
        end
    end

    local newBullets = {}
    for i,v in ipairs(enemies) do
        v:update(dt, newBullets)
        if player:collided(v) then
            STATE = "menu"
        elseif v.gone then
            table.remove(enemies, i)
            table.insert(enemies, Enemy1())
        end
    end

    for i,v in ipairs(newBullets) do
        v:target(player)
        table.insert(enemyBullets, v)
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
    player:draw()
end
