Enemy1 = Object:extend()

function Enemy1:new()
    self.image = love.graphics.newImage("assets/enemy1_white.png")
    self.width = self.image:getWidth()
    self.height = self.image:getHeight();
    self.x =  love.math.random(window_width - (self.width))
    self.y = -100
    self.speed = 100 + love.math.random(100)
    self.gone = false
end

function Enemy1:update(dt)
    self.y = self.y + (self.speed * dt)
    if self.y > window_height + 100 then
        self.gone = true
    end
end

function Enemy1:draw()
    love.graphics.draw(self.image, self.x, self.y)
end
