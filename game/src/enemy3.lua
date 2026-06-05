local Enemy = require "src/enemy"
local Enemy3 = Enemy:extend()

function Enemy3:new(path)
    Enemy3.super.new(self, path)
    self.imageQuad = Images.enemy3
    self.width = self.imageQuad.width
    self.height = self.imageQuad.height
    self.health = 6
    self.score = 20
end

function Enemy3:fire()
    local startY = self.path.y + self.height
    local speed = 100 + self.path.speed
    return {
        {
            x = self.path.x,
            y = startY,
            speed = speed,
            angle = 90,
            colour = self.colour
        },
        {
            x = self.path.x + 32,
            y = startY,
            speed = speed,
            angle = 90,
            colour = self.colour
        }
    }
end

function Enemy3:draw()
    self.imageQuad:draw(self.colour, self.path.x, self.path.y)
end

return Enemy3
