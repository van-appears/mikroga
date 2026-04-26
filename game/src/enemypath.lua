local EnemyPath = Object:extend()

local DROP = 1
local STRAFE = 2
local BOUNCE = 3
local DEFINED = 4

function EnemyPath:new()
    self.speedX = 0
    self.speedY = 0
end

function EnemyPath:random()
    local path = EnemyPath()
    path.type = love.math.random(3)
    if path.type == DROP then
        path:initDrop()
    elseif path.type == STRAFE then
        path:initStrafe()
    elseif path.type == BOUNCE then
        path:initBounce()
    end
    return path
end

function EnemyPath:build(opts, player)
    local path = EnemyPath()
    path.type = DEFINED
    path.x = opts.x
    path.y = opts.y
    local speed = opts.speed or (100 + love.math.random(100))
    if opts.angle then
        path.speedX = speed * math.cos(opts.angle * math.pi * 2.0 / 360)
        path.speedY = speed * math.sin(opts.angle * math.pi * 2.0 / 360)
    elseif opts.target and player then
        local diffX = player.x - path.x
        local diffY = player.y - path.y
        local dist = math.sqrt(diffX * diffX + diffY * diffY)
        path.speedX = 300 * diffX / dist
        path.speedY = 300 * diffY / dist
    else
        path.speedX = speed
    end
    return path
end

function EnemyPath:initDrop()
    local width = WINDOW_WIDTH - 64
    local speed = 100 + love.math.random(100)
    self.x = love.math.random(width)
    self.y = -64
    self.speedY = speed
    self.speedX = 0

    self.targetY = love.math.random(WINDOW_HEIGHT)
    if self.targetY > WINDOW_HEIGHT / 2 then
        self.targetY = nil
    end
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

function EnemyPath:initBounce()
    local edge = love.math.random(3)
    local height = WINDOW_HEIGHT / 2
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
    self:setRandomTarget()
end

function EnemyPath:setRandomTarget()
    self.targetX = 64 + love.math.random(WINDOW_WIDTH - 64 - 64)
    self.targetY = 64 + love.math.random(WINDOW_HEIGHT - 64 - 64)

    local speed = 100 + love.math.random(100)
    local diffX = self.targetX - self.x
    local diffY = self.targetY - self.y
    local dist = math.sqrt(diffX * diffX + diffY * diffY)
    self.speedX = speed * diffX / dist
    self.speedY = speed * diffY / dist
end

function EnemyPath:update(dt)
    if self.type == 3 then
        self.x = self.x + (self.speedX * dt)
        self.y = self.y + (self.speedY * dt)
        if math.abs(self.targetX - self.x) < 1
            and math.abs(self.targetY - self.y) < 1 then
            self:setRandomTarget()
        end
    elseif self.type == 1 and self.targetY then
        if not (self.radian == nil) then
            self.speedY = self.speedY / 1.03
            self.radian = self.radian + (math.pi * dt)
            self.y = self.y + (dt * self.speedY * math.cos(self.radian))
            if self.radian > math.pi * 2.5 then
                self.targetY = nil
                self.radian = nil
                self.speedY = 0
            end
        elseif self.y > self.targetY then
            self.radian = 0.0
        else
            self.x = self.x + (self.speedX * dt)
            self.y = self.y + (self.speedY * dt)
        end
    else
        self.x = self.x + (self.speedX * dt)
        self.y = self.y + (self.speedY * dt)
    end
end

return EnemyPath
