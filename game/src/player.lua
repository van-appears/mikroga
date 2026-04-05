Player = Object:extend()

function Player:new()
    self.image = love.graphics.newImage("assets/mikroga_white.png")
    self.speed = 500
    self.width = self.image:getWidth()
    self.height = self.image:getHeight();
    self.x = (window_width - self.width) / 2 
    self.y = window_height - (self.height * 2)
end

function Player:update(dt)
    if love.keyboard.isDown("left") then
        self.x = self.x - self.speed * dt
    end
    if love.keyboard.isDown("right") then
        self.x = self.x + self.speed * dt
    end
    if love.keyboard.isDown("up") then
        self.y = self.y - self.speed * dt
    end
    if love.keyboard.isDown("down") then
        self.y = self.y + self.speed * dt
    end

    self:limit()
end

function Player:limit()
    if self.x < 0 then
        self.x = 0
    elseif self.x + self.width > window_width then
        self.x = window_width - self.width
    end

    if self.y < 0 then
        self.y = 0
    elseif self.y + self.height > window_height then
        self.y = window_height - self.height
    end
end

function Player:draw()
    love.graphics.draw(self.image, self.x, self.y)
end

function Player:collided(enemy)
    -- allow small amounts of grace
    local e_left = enemy.x + 1
    local e_right = enemy.x + enemy.width - 2
    local e_top = enemy.y + 1
    local e_bottom = enemy.y + enemy.height - 2

    -- only consider the main trunk of the ship
    local p_left = self.x + 9
    local p_right = self.x + self.width - 9
    local p_top = self.y + 13
    local p_bottom = self.y + self.height - 13

    return  e_right > p_left
        and e_left < p_right
        and e_bottom > p_top
        and e_top < p_bottom
end