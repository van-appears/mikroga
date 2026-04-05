local player
local enemies
local counter

function love.load()
    Object = require "lib/classic"
    require "src/player"
    require "src/enemy1"

    -- global dimension
    window_width = love.graphics.getWidth()
    window_height = love.graphics.getHeight()

    player = Player()
    enemies = {}
    counter = 0

    table.insert(enemies, Enemy1())
end

function love.update(dt)
    counter = counter + dt
    player:update(dt)

    for i,v in ipairs(enemies) do
        v:update(dt)
        if player:collided(v) then
            love.load()
        elseif v.gone then
            table.remove(enemies, i)
            table.insert(enemies, Enemy1())
        end
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
    player:draw()
end
