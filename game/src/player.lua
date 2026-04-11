Player = Object:extend()

function Player:new()
    self.image = love.graphics.newImage("assets/mikroga_white.png")
    self.speed = 500
    self.width = self.image:getWidth()
    self.height = self.image:getHeight();
    self.x = (WINDOW_WIDTH - self.width) / 2
    self.y = WINDOW_HEIGHT - self.height * 2
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
    elseif self.x + self.width > WINDOW_WIDTH then
        self.x = WINDOW_WIDTH - self.width
    end

    if self.y < 0 then
        self.y = 0
    elseif self.y + self.height > WINDOW_HEIGHT then
        self.y = WINDOW_HEIGHT - self.height
    end
end

function Player:draw()
    love.graphics.draw(self.image, self.x, self.y)
end

function Player:collided(enemy)
    -- allow small amounts of grace
    local eLeft = enemy.x + 1
    local eRight = enemy.x + enemy.width - 2
    local eTop = enemy.y + 1
    local eBottom = enemy.y + enemy.height - 2

    -- only consider the main trunk of the ship
    local pLeft = self.x + 9
    local pRight = self.x + self.width - 9
    local pTop = self.y + 13
    local pBottom = self.y + self.height - 13

    return  eRight > pLeft
        and eLeft < pRight
        and eBottom > pTop
        and eTop < pBottom
end
