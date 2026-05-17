local EnemyPath = Object:extend()
local CurvedPath = Object:extend()
local StraightPath = Object:extend()

function EnemyPath:drop(startX, speedY)
    return EnemyPath:angled(startX, -100, speedY, 90)
end

function EnemyPath:strafeRight(startY, speedX)
    return EnemyPath:angled(-100, startY, speedX, 0)
end

function EnemyPath:strafeLeft(startY, speedX)
    return EnemyPath:angled(WINDOW_WIDTH + 100, startY, speedX, 180)
end

function EnemyPath:angled(startX, startY, speed, angle)
    local path = StraightPath()
    path.x = startX
    path.y = startY
    path.speedX = speed * math.cos(angle * math.pi * 2.0 / 360)
    path.speedY = speed * math.sin(angle * math.pi * 2.0 / 360)
    return path
end

function EnemyPath:curvedDrop(startX, speed, width, period)
    local path = CurvedPath()
    path.x = startX
    path.y = -100
    path.speedY = speed
    path.width = width
    path.period = period
    return path
end

function EnemyPath:defined(opts, target)
    local path = StraightPath()
    path.x = opts.x
    path.y = opts.y
    if opts.angle then
        local speed = opts.speed or (100 + love.math.random(100))
        path.speedX = speed * math.cos(opts.angle * math.pi * 2.0 / 360)
        path.speedY = speed * math.sin(opts.angle * math.pi * 2.0 / 360)
    elseif opts.target and target then
        local diffX = target.x + (target.width / 2) - path.x
        local diffY = target.y - (target.height / 2) - path.y
        local dist = math.sqrt(diffX * diffX + diffY * diffY)
        local speed = opts.speed or 300
        path.speedX = speed * diffX / dist
        path.speedY = speed * diffY / dist
    end
    return path
end

function StraightPath:update(dt)
    self.x = self.x + (self.speedX * dt)
    self.y = self.y + (self.speedY * dt)
end

function CurvedPath:new()
    self.counter = 0
end

function CurvedPath:update(dt)
    self.counter = self.counter + dt
    self.x = self.x + self.width * dt * math.sin(self.counter * math.pi * 2 / self.period)
    self.y = self.y + self.speedY * dt * math.abs(math.cos(self.counter * math.pi * 2 / self.period))
end

return EnemyPath
