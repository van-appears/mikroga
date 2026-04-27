Hud = Object:extend()

local font
local lifeImage
local lifeWidth

function Hud:new(game)
    self.game = game
    love.graphics.setFont(love.graphics.newFont(20))
    font = love.graphics.getFont()

    lifeImage = Images.life
    lifeWidth = lifeImage:getWidth()
end

function Hud:draw()
    local scoreText = love.graphics.newText(font)
    scoreText:add({{1,1,1}, string.format("%d", self.game.score)}, 0, 0)
    love.graphics.draw(scoreText, 10, 10)

    for i=1, self.game.lives do
        love.graphics.draw(lifeImage, WINDOW_WIDTH - 10 - (i * (lifeWidth + 2)), 10)
    end
end

return Hud
