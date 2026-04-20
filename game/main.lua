function love.load()
    -- globals
    Object = require "lib/classic"
    Images = require "src/images"
    Game = require "src/game"
    Menu = require "src/menu"
    Scoreboard = require "src/scoreboard"

    WINDOW_WIDTH = love.graphics.getWidth()
    WINDOW_HEIGHT = love.graphics.getHeight()
    STATE = "menu"

    Game:load()
    Images:load()
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
