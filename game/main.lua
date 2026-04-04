local player

function love.load()
	Object = require "lib/classic"
    require "src/player"

	window_width = love.graphics.getWidth()
    window_height = love.graphics.getHeight()
	player = Player()
end

function love.update(dt)
    player:update(dt)
end

function love.draw()
    player:draw()
end
