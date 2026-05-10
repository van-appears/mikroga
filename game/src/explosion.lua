local Explosion = Object:extend()

function Explosion:buildPaths(source)
    local pieces = 8 + math.floor(love.math.random(8))
    local angle = love.math.random(360)
    local pathObj = source.path or source
    local startX = pathObj.x + (source.width - Images.explosion.width) / 2
    local startY = pathObj.y + (source.height - Images.explosion.height) / 2
    local paths = {}
    for i = 1, pieces do
        table.insert(
            paths,
            {
                x = startX,
                y = startY,
                angle = angle,
                speed = 160 + love.math.random(160)
            }
        )
        angle = angle + 360 / pieces
    end
    return paths
end

function Explosion:new(path)
    self.imageQuad = Images.explosion
    self.path = path
    self.life = 0
    self.gone = false
end

function Explosion:update(dt)
    self.life = self.life + dt
    self.path:update(dt)
    self.path.speedX = self.path.speedX * 0.95
    self.path.speedY = self.path.speedY * 0.95
    if self.life >= 1 then
        self.gone = true
    end
end

function Explosion:draw()
    self.imageQuad:draw(1 + math.floor(7 * self.life), self.path.x, self.path.y)
end

return Explosion
