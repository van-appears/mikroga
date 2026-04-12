function love.load()
    Object = require "lib/classic"
    require "src/game"
    require "src/menu"
    require "src/enemybullet"
    require "src/player"
    require "src/enemy1"

    -- global dimension
    WINDOW_WIDTH = love.graphics.getWidth()
    WINDOW_HEIGHT = love.graphics.getHeight()
    STATE = "menu"

    Menu:prepare()
end

function love.update(dt)
    if STATE == "menu" then
        Menu:update(dt)
    elseif STATE == "prepare" then
        Game:prepare()
    elseif STATE == "playing" then
        Game:update(dt)
    end
end

function love.draw()
    if STATE == "playing" then
        Game:draw()
    else
        Menu:draw()
    end
end
