local Baddy1 = Object:extend()
local EnemyPath = require "src/enemypath"

function Baddy1:new()
    self.image = Images.baddy1
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.path = EnemyPath:arrive((WINDOW_WIDTH - self.width) / 2, 200, 200)
    self.gone = false
    self.health = 50
    self.score = 100
    self.counter = 0
    self.type = BADDY1
end

function Baddy1:update(dt, newBullets)
    self.counter = self.counter + dt
    self.path:update(dt)
end

function Baddy1:draw()
    love.graphics.draw(self.image, self.path.x, self.path.y)
end

return Baddy1
