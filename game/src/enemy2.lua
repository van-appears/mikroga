local Enemy2 = Object:extend()

function Enemy2:new(path)
    self.imageQuad = Images.enemy2
    self.width = self.imageQuad.width
    self.height = self.imageQuad.height
    self.colour = Enemy2:randomColour()
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
        local startX = self.path.x + (self.width - Images.enemybullet.width) / 2
        local startY = self.path.y + self.height
        local speed = 100 + love.math.random(100)
        table.insert(newBullets, {
            x = startX,
            y = startY,
            speed = speed,
            angle = 36,
            colour = self.colour
        })
        table.insert(newBullets, {
            x = startX,
            y = startY,
            speed = speed,
            angle = 72,
            colour = self.colour
        })
        table.insert(newBullets, {
            x = startX,
            y = startY,
            speed = speed,
            angle = 108,
            colour = self.colour
        })
        table.insert(newBullets, {
            x = startX,
            y = startY,
            speed = speed,
            angle = 144,
            colour = self.colour
        })
        self.fired = true
    end
end

function Enemy2:draw()
    self.imageQuad:draw(self.colour, self.path.x, self.path.y)
end

function Enemy2:randomColour()
    if love.math.random(10) <= 5 then
        return BLACK
    else
        return WHITE
    end
end

return Enemy2
