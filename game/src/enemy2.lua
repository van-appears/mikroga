local Enemy2 = Object:extend()

function Enemy2:new()
    self.image = Images.enemy2
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.x = love.math.random(WINDOW_WIDTH - self.width)
    self.y = -100
    self.speed = 100 + love.math.random(100)
    self.gone = false
    self.fired = false
    self.health = 6
end

function Enemy2:update(dt, newBullets)
    self.y = self.y + (self.speed * dt)
    if self.y > WINDOW_HEIGHT + 100 then
        self.gone = true
    end
    if not self.fired and self.y > 100 then
        -- create the bullet using the centre point of the enemy ship X
        -- and the front of the ship
        local startX = self.x + self.width / 2
        local startY = self.y + self.height
        table.insert(newBullets, {
            startX,
            startY,
            300 * math.cos(36 * math.pi * 2.0 / 360),
            300 * math.sin(36 * math.pi * 2.0 / 360)
        })
        table.insert(newBullets, {
            startX,
            startY,
            300 * math.cos(72 * math.pi * 2.0 / 360),
            300 * math.sin(72 * math.pi * 2.0 / 360)
        })
        table.insert(newBullets, {
            startX,
            startY,
            300 * math.cos(108 * math.pi * 2.0 / 360),
            300 * math.sin(108 * math.pi * 2.0 / 360)
        })
        table.insert(newBullets, {
            startX,
            startY,
            300 * math.cos(144 * math.pi * 2.0 / 360),
            300 * math.sin(144 * math.pi * 2.0 / 360)
        })
        print(newBullets)
        self.fired = true
    end
end

function Enemy2:draw()
    love.graphics.draw(self.image, self.x, self.y)
end

return Enemy2
