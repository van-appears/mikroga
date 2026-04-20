local Enemy1 = Object:extend()

function Enemy1:new()
    self.image = Images.enemy1
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.x = love.math.random(WINDOW_WIDTH - self.width)
    self.y = -100
    self.speed = 100 + love.math.random(100)
    self.gone = false
    self.fired = false
    self.health = 3
end

function Enemy1:update(dt, newBullets)
    self.y = self.y + (self.speed * dt)
    if self.y > WINDOW_HEIGHT + 100 then
        self.gone = true
    end
    if not self.fired and self.y > 100 then
        -- create the bullet using the centre point of the enemy ship X
        -- and the front of the ship
        table.insert(newBullets, {self.x + self.width / 2, self.y + self.height})
        self.fired = true
    end
end

function Enemy1:draw()
    love.graphics.draw(self.image, self.x, self.y)
end

return Enemy1
