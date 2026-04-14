PlayerBullet = Object:extend()

function PlayerBullet:new(x, y)
    self.image = love.graphics.newImage("assets/mikroga_bullet.png")
    self.width = self.image:getWidth()
    self.height = self.image:getHeight();
    self.x = x
    self.y = y
    self.speedY = -300
    self.gone = false
end

function PlayerBullet:update(dt)
    self.y = self.y + (self.speedY * dt)
    if self.y > WINDOW_HEIGHT + 100 then
        self.gone = true
    end
end

function PlayerBullet:limit()
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

function PlayerBullet:collided(enemy)
    -- allow small amounts of grace
    local eLeft = enemy.x + 1
    local eRight = enemy.x + enemy.width - 2
    local eTop = enemy.y + 1
    local eBottom = enemy.y + enemy.height - 2

    local bLeft = self.x
    local bRight = self.x + self.width
    local bTop = self.y
    local bBottom = self.y + self.height

    return  eRight > bLeft
        and eLeft < bRight
        and eBottom > bTop
        and eTop < bBottom
end

function PlayerBullet:draw()
    love.graphics.draw(self.image, self.x, self.y)
end
