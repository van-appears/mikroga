local Explosion = Object:extend()
local EnemyPath = require "src/enemypath"

function Explosion:buildPaths(source)
    local pieces = love.math.random(8, 16)
    local angle = love.math.random(360)
    local pathObj = source.path or source
    local startX = pathObj.x + (source.width - Images.explosion.width) / 2
    local startY = pathObj.y + (source.height - Images.explosion.height) / 2
    local paths = {}
    for i = 1, pieces do
        table.insert(
            paths,
            EnemyPath:angled(startX, startY, 100 + love.math.random(220), angle)
        )
        angle = angle + 360 / pieces
    end
    return paths
end

function Explosion:new(path)
    self.imageQuad = Images.explosion
    self.path = path
    self.counter = 0
    self.gone = false
    self.maxCounter = love.math.random(10, 15) / 10
end

function Explosion:update(dt)
    self.counter = self.counter + dt
    self.path:update(dt)
    self.path.speedX = self.path.speedX * 0.95
    self.path.speedY = self.path.speedY * 0.95
    if self.counter >= self.maxCounter then
        self.gone = true
    end
end

function Explosion:draw()
    self.imageQuad:draw(1 + math.floor(7 * self.counter / self.maxCounter), self.path.x, self.path.y)
end

return Explosion
