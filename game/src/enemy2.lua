local Enemy = require "src/enemy"
local Enemy2 = Enemy:extend()

function Enemy2:new(path)
    Enemy2.super.new(self, path)
    self.imageQuad = Images.enemy2
    self.width = self.imageQuad.width
    self.height = self.imageQuad.height
    self.health = 6
    self.score = 20
end

function Enemy2:fire()
    local startX = self.path.x + (self.width - Images.enemybullet.width) / 2
    local startY = self.path.y + self.height
    local speed = 100 + love.math.random(100)
    return {
        {
            x = startX,
            y = startY,
            speed = speed,
            angle = 36,
            colour = self.colour
        },
        {
            x = startX,
            y = startY,
            speed = speed,
            angle = 72,
            colour = self.colour
        },
        {
            x = startX,
            y = startY,
            speed = speed,
            angle = 108,
            colour = self.colour
        },
        {
            x = startX,
            y = startY,
            speed = speed,
            angle = 144,
            colour = self.colour
        }
    }
end

function Enemy2:draw()
    self.imageQuad:draw(self.colour, self.path.x, self.path.y)
end

return Enemy2
