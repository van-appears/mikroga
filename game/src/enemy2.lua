local Enemy2 = Object:extend()

function Enemy2:new(path)
    self.image = Images.enemy2
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.gone = false
    self.fired = false
    self.health = 6
    self.score = 20
    self.counter = 0
    self.path = path
end

function Enemy2:update(dt, newBullets)
    self.counter = self.counter + dt
    self.path:update(dt)
    if self.path.y > WINDOW_HEIGHT + 100 or
        self.path.y < -100 or
        self.path.x > WINDOW_WIDTH + 100 or
        self.path.x < -100 then
        self.gone = true
    end
    if not self.fired and self.counter > 1.5 then
        -- create the bullet using the centre point of the enemy ship X
        -- and the front of the ship
        local startX = self.path.x + self.width / 2
        local startY = self.path.y + self.height
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
        self.fired = true
    end
end

function Enemy2:draw()
    love.graphics.draw(self.image, self.path.x, self.path.y)
end

return Enemy2
