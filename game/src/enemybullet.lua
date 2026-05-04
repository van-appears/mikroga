local EnemyBullet = Object:extend()

function EnemyBullet:new(path, colour)
    self.image = Images.enemybullet
    self.width = self.image.width
    self.height = self.image.height
    self.colour = colour
    self.path = path
    self.gone = false
end

function EnemyBullet:update(dt)
    self.path:update(dt)
    if self.path.x < 0 - self.width
        or self.path.x > WINDOW_WIDTH
        or self.path.y < 0 - self.height
        or self.path.y > WINDOW_HEIGHT then
        self.gone = true
    end
end

function EnemyBullet:draw()
    self.image:draw(self.colour, self.path.x, self.path.y)
end

return EnemyBullet
