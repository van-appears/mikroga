local Baddy1 = Object:extend()
local EnemyPath = require "src/enemypath"
local FireTrigger = require "src/firetrigger"

function Baddy1:new()
    self.image = Images.baddy1
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.path = EnemyPath:arrive((WINDOW_WIDTH - self.width) / 2, 200, 200)
    self.trigger1 = FireTrigger:every(0.5, 0.0, self, self.fire1)
    self.trigger2 = FireTrigger:every(3.0, 1.5, self, self.fire2)
    self.gone = false
    self.health = 150
    self.score = 100
    self.counter = 0
    self.type = BADDY1
end

function Baddy1:update(dt, newBullets)
    self.counter = self.counter + dt
    self.path:update(dt)
    if self.path.arrived then
        self.path = EnemyPath:figure8(self.path.x, self.path.y, 150, 150, 5.0)
    end
    self.trigger1:update(dt, newBullets)
    self.trigger2:update(dt, newBullets)
end

function Baddy1:draw()
    love.graphics.draw(self.image, self.path.x, self.path.y)
end

function Baddy1:fire1()
    return {
        {
            x = self.path.x + 45 - Images.enemybullet.width / 2,
            y = self.path.y + self.height,
            speed = 300,
            colour = BLACK
        },
        {
            x = self.path.x + 82 - Images.enemybullet.width / 2,
            y = self.path.y + self.height,
            speed = 300,
            colour = BLACK
        }
    }
end

function Baddy1:fire2()
    return {
        {
            x = self.path.x + 12 - Images.enemybullet.width / 2,
            y = self.path.y + self.height,
            target = true,
            colour = WHITE
        },
        {
            x = self.path.x + 115 - Images.enemybullet.width / 2,
            y = self.path.y + self.height,
            target = true,
            colour = WHITE
        }
    }
end

return Baddy1
