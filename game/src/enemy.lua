local Enemy = Object:extend()

function Enemy:new(path)
    self.colour = Enemy:randomColour()
    self.gone = false
    self.fired = false
    self.health = 3
    self.score = 10
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
    if not self.fired and self.counter > 1.5 then
        self:fire(newBullets)
        self.fired = true
    end
end

function Enemy:fire(newBullets)
    -- to be implemented by objects extending enemy
end

function Enemy:randomColour()
    if love.math.random(10) <= 5 then
        return BLACK
    else
        return WHITE
    end
end

return Enemy
