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

    -- colour constants
    BLACK = 2
    WHITE = 1
    -- enemy type constants
    TARGETER = 1
    SPREADER = 2
    FORWARDER = 3
    BADDY1 = 4
    BADDY2 = 5
    -- path type constants
    INTERNAL = 1
    DROP = 2
    CURVED = 3
    STRAFE_LEFT = 4
    STRAFE_RIGHT = 5
    TWEEN = 6

    Game:load()
    Images:load()
end

function love.update(dt)
    if STATE == "menu" then
        Menu:update(dt)
    elseif STATE == "prepare" then
        Game:prepare()
    elseif STATE == "begin" or STATE == "playing" or STATE == "death" or STATE == "completed" then
        Game:update(dt)
    end
end

function love.draw()
    if STATE == "begin" or STATE == "playing" or STATE == "death" or STATE == "completed" then
        Game:draw()
    else
        Menu:draw()
    end
end
