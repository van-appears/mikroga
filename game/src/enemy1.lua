local Enemy1 = Object:extend()

function Enemy1:new(path)
    self.image = Images.enemy1
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.gone = false
    self.fired = false
    self.health = 3
    self.score = 10
    self.counter = 0
    self.path = path
end

function Enemy1:update(dt, newBullets)
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
        table.insert(newBullets, {self.path.x + self.width / 2, self.path.y + self.height})
        self.fired = true
    end
end

function Enemy1:draw()
    love.graphics.draw(self.image, self.path.x, self.path.y)
end

return Enemy1
