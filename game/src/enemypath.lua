local EnemyPath = Object:extend()

function EnemyPath:new()
    self.type = love.math.random(3)
    if self.type == 1 then
        self:initDrop()
    elseif self.type == 2 then
        self:initStrafe()
    elseif self.type == 3 then
        self:initAngled()
    end
end

function EnemyPath:initDrop()
    local width = WINDOW_WIDTH - 64
    local speed = 100 + love.math.random(100)
    self.x = love.math.random(width)
    self.y = -64
    self.speedY = speed
    self.speedX = 0
end

function EnemyPath:initStrafe()
    local height = WINDOW_HEIGHT / 2
    local speed = 100 + love.math.random(100)
    self.speedY = 0
    self.y = love.math.random(height)
    if love.math.random(2) == 1 then
        self.x = -64
        self.speedX = speed
    else
        self.x = WINDOW_WIDTH + 64
        self.speedX = -speed
    end
end

function EnemyPath:initAngled()
    local edge = love.math.random(3)
    local speed = 100 + love.math.random(100)
    local height = WINDOW_HEIGHT / 2
    local width = WINDOW_WIDTH / 2
    local targetX = 64 + love.math.random(WINDOW_WIDTH - 64 - 64)
    local targetY = 64 + love.math.random(WINDOW_HEIGHT - 64 - 64)

    if edge == 1 then
        self.x = -64
        self.y = love.math.random(height)
    elseif edge == 2 then
        self.x = WINDOW_WIDTH + 64
        self.y = love.math.random(height)
    elseif edge == 3 then
        self.x = love.math.random(WINDOW_WIDTH - 64)
        self.y = -64
    end

    local diffX = targetX - self.x
    local diffY = targetY - self.y
    local dist = math.sqrt(diffX * diffX + diffY * diffY)
    self.speedX = speed * diffX / dist
    self.speedY = speed * diffY / dist
end

function EnemyPath:update(dt)
    self.x = self.x + (self.speedX * dt)
    self.y = self.y + (self.speedY * dt)
end

return EnemyPath
