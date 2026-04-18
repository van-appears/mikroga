local EnemyBullet = Object:extend()

function EnemyBullet:new(coords)
    self.image = Images.enemybullet
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.x = coords[1] - self.width / 2
    self.y = coords[2]
    self.gone = false
    -- default fire is straight forwards
    self.speedX = 0
    self.speedY = 300
end

function EnemyBullet:target(player)
    local diffX = player.x - self.x
    local diffY = player.y - self.y
    local dist = math.sqrt(diffX * diffX + diffY * diffY)
    self.speedX = 300 * diffX / dist
    self.speedY = 300 * diffY / dist
end

function EnemyBullet:update(dt)
    self.y = self.y + (self.speedY * dt)
    self.x = self.x + (self.speedX * dt)
    if self.x < 0
        or self.x > WINDOW_WIDTH
        or self.y < 0
        or self.y > WINDOW_HEIGHT then
        self.gone = true
    end
end

function EnemyBullet:draw()
    love.graphics.draw(self.image, self.x, self.y)
end

return EnemyBullet
