local EnemyBullet = Object:extend()

function EnemyBullet:new(path)
    self.image = Images.enemybullet
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.path = path
    self.gone = false
end

function EnemyBullet:update(dt)
    self.path:update(dt)
    if self.path.x < 0
        or self.path.x > WINDOW_WIDTH
        or self.path.y < 0
        or self.path.y > WINDOW_HEIGHT then
        self.gone = true
    end
end

function EnemyBullet:draw()
    love.graphics.draw(self.image, self.path.x, self.path.y)
end

return EnemyBullet
