local Baddy2 = Object:extend()
local EnemyPath = require "src/enemypath"
local FireTrigger = require "src/firetrigger"

function Baddy2:new()
    self.image = Images.baddy2
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.path = EnemyPath:arrive((WINDOW_WIDTH - self.width) / 2, 200, 200)
    self.trigger1 = FireTrigger:every(0.55, 0.0, self, self.fire1)
    self.trigger2 = FireTrigger:every(0.65, 0.3, self, self.fire2)
    self.gone = false
    self.health = 150
    self.score = 100
    self.counter = 0
    self.type = BADDY1
    self.fireAngle1 = 80
    self.fireAngle1Change = -10
    self.fireAngle2 = 100
    self.fireAngle2Change = 10
end

function Baddy2:update(dt, newBullets)
    self.counter = self.counter + dt
    self.path:update(dt)
    if self.path.arrived then
        self.path = EnemyPath:figure8(self.path.x, self.path.y, 175, 150, 4.0)
    end
    self.trigger1:update(dt, newBullets)
    self.trigger2:update(dt, newBullets)
end

function Baddy2:draw()
    love.graphics.draw(self.image, self.path.x, self.path.y)
end

function Baddy2:fire1()
    self.fireAngle1 = self.fireAngle1 + self.fireAngle1Change
    if self.fireAngle1 < 10 then
        self.fireAngle1Change = -self.fireAngle1Change
    elseif self.fireAngle1 > 170 then
        self.fireAngle1Change = -self.fireAngle1Change
    end

    return {
        {
            x = self.path.x + 45 - Images.enemybullet.width / 2,
            y = self.path.y + self.height,
            speed = 300,
            angle = self.fireAngle1,
            colour = BLACK
        }
    }
end

function Baddy2:fire2()
    self.fireAngle2 = self.fireAngle2 + self.fireAngle2Change
    if self.fireAngle2 < 10 then
        self.fireAngle2Change = -self.fireAngle2Change
    elseif self.fireAngle2 > 170 then
        self.fireAngle2Change = -self.fireAngle2Change
    end

    return {
        {
            x = self.path.x + 12 - Images.enemybullet.width / 2,
            y = self.path.y + self.height,
            speed = 300,
            angle = self.fireAngle2,
            colour = WHITE
        }
    }
end

return Baddy2
