local player
local enemies
local enemyBullets
local counter

function love.load()
    Object = require "lib/classic"
    require "src/enemybullet"
    require "src/player"
    require "src/enemy1"

    -- global dimension
    WINDOW_WIDTH = love.graphics.getWidth()
    WINDOW_HEIGHT = love.graphics.getHeight()

    player = Player()
    enemies = {}
    enemyBullets = {}
    counter = 0

    table.insert(enemies, Enemy1())
end

function love.update(dt)
    counter = counter + dt
    player:update(dt)

    for i,v in ipairs(enemyBullets) do
        v:update(dt)
        if player:collided(v) then
            love.load()
        elseif v.gone then
            table.remove(enemyBullets, i)
        end
    end

    local newBullets = {}
    for i,v in ipairs(enemies) do
        v:update(dt, newBullets)
        if player:collided(v) then
            love.load()
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

function love.draw()
    for i,v in ipairs(enemies) do
        v:draw()
    end
    for i,v in ipairs(enemyBullets) do
        v:draw()
    end
    player:draw()
end
