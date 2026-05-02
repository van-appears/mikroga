local Explosion = Object:extend()

function Explosion:buildPaths(enemy)
    local pieces = 5 + math.floor(love.math.random(5))
    local angle = love.math.random(360)
    local startX = enemy.path.x + (enemy.width - Images.explosionsize) / 2
    local startY = enemy.path.y + (enemy.height - Images.explosionsize) / 2
    local paths = {}
    for i = 1, pieces do
        table.insert(
            paths,
            {
                x = startX,
                y = startY,
                angle = angle,
                speed = 100 + love.math.random(100)
            }
        )
        angle = angle + 360 / pieces
    end
    return paths
end

function Explosion:new(path)
    self.image = Images.explosion
    self.imageframes = Images.explosionframes
    self.width = Images.explosionsize
    self.height = Images.explosionsize
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
    love.graphics.draw(
        self.image,
        self.imageframes[1 + math.floor(7 * self.life)],
        self.path.x,
        self.path.y)
end

return Explosion
