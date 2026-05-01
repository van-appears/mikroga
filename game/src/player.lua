local Player = Object:extend()

function Player:new()
    self.image = Images.player
    self.imageinvulnerable = Images.playerinvulnerable
    self.speed = 500
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.bulletcountdown = 0
    self.invulnerable = 0
    self.x = (WINDOW_WIDTH - self.width) / 2
    self.y = WINDOW_HEIGHT - self.height * 2
end

function Player:update(dt, newBullets)
    self.bulletcountdown = self.bulletcountdown - dt
    self.invulnerable = self.invulnerable - dt

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
    if love.keyboard.isDown("space") and self.bulletcountdown <= 0 then
        -- magic numbers based on the location of the cannons in the
        -- mikroga image
        table.insert(newBullets, {self.x + 23, self.y})
        table.insert(newBullets, {self.x + 64 - 23, self.y})
        self.bulletcountdown = 0.2
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
    if self.invulnerable > 0 then
        local nint, frac = math.modf(self.invulnerable)
        if (frac >= 0.25 and frac < 0.5) or frac >= 0.75 then
            love.graphics.draw(self.imageinvulnerable, self.x, self.y)
        else
            love.graphics.draw(self.image, self.x, self.y)
        end
    else
        love.graphics.draw(self.image, self.x, self.y)
    end
end

function Player:collided(enemy)
    if self.invulnerable > 0 then
        return false
    end

    -- ignore 1px border inside enemy image
    local eLeft = enemy.path.x + 1
    local eRight = enemy.path.x + enemy.width - 2
    local eTop = enemy.path.y + 1
    local eBottom = enemy.path.y + enemy.height - 2

    -- only consider the main trunk of the ship
    local pLeft = self.x + 9
    local pRight = self.x + self.width - 9
    local pTop = self.y + 13
    local pBottom = self.y + self.height - 13

    return eRight > pLeft
        and eLeft < pRight
        and eBottom > pTop
        and eTop < pBottom
end

function Player:setInvulnerable()
    self.invulnerable = 3
end

return Player;
