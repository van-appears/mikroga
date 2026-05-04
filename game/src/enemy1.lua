local Enemy1 = Object:extend()

function Enemy1:new(path)
    self.imageQuad = Images.enemy1
    self.width = self.imageQuad.width
    self.height = self.imageQuad.height
    self.colour = Enemy1:randomColour()
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
        table.insert(newBullets, {
            x = self.path.x + (self.width - Images.enemybullet.width) / 2,
            y = self.path.y + self.height,
            target = true,
            colour = self.colour
        })
        self.fired = true
    end
end

function Enemy1:draw()
    self.imageQuad:draw(self.colour, self.path.x, self.path.y)
end

function Enemy1:randomColour()
    if love.math.random(10) <= 5 then
        return BLACK
    else
        return WHITE
    end
end

return Enemy1
