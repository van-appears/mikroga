local Enemy = require "src/enemy"
local Enemy1 = Enemy:extend()

function Enemy1:new(path)
    Enemy1.super.new(self, path)
    self.imageQuad = Images.enemy1
    self.width = self.imageQuad.width
    self.height = self.imageQuad.height
end

function Enemy1:fire(newBullets)
    -- create the bullet using the centre point of the enemy ship X
    -- and the front of the ship
    table.insert(newBullets, {
        x = self.path.x + (self.width - Images.enemybullet.width) / 2,
        y = self.path.y + self.height,
        target = true,
        colour = self.colour
    })
end

function Enemy1:draw()
    self.imageQuad:draw(self.colour, self.path.x, self.path.y)
end

return Enemy1
