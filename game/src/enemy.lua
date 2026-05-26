local Enemy = Object:extend()
local FireTrigger = require "src/firetrigger"

function Enemy:new(path)
    self.colour = nil
    self.trigger = FireTrigger:once(1.5, self, self.fire)
    self.gone = false
    self.health = 0
    self.score = 0
    self.counter = 0
    self.path = path
end

function Enemy:update(dt, newBullets)
    self.counter = self.counter + dt
    self.path:update(dt)
    if self.path.y > WINDOW_HEIGHT + 100 or
        self.path.y < -100 or
        self.path.x > WINDOW_WIDTH + 100 or
        self.path.x < -100 then
        self.gone = true
    end
    self.trigger:update(dt, newBullets)
end

function Enemy:fire()
    -- to be implemented by objects extending enemy
end

return Enemy
