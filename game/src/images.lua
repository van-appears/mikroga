Images = Object:extend()

local QuadImage = Object:extend()

function Images:load()
    self.playerinvulnerable = love.graphics.newImage("assets/mikroga_invulnerable.png")
    self.life = love.graphics.newImage("assets/life.png")
    self.planet = love.graphics.newImage("assets/planet.png")

    self.player = QuadImage:build("assets/mikroga.png", 64, 60, 1)
    self.playerbullet = QuadImage:build("assets/mikroga_bullet.png", 16, 32, 1)
    self.enemy1 = QuadImage:build("assets/enemy1.png", 64, 64, 1)
    self.enemy2 = QuadImage:build("assets/enemy2.png", 64, 64, 1)
    self.enemy3 = QuadImage:build("assets/enemy3.png", 64, 64, 1)
    self.enemybullet = QuadImage:build("assets/enemy_bullet.png", 32, 32, 1)
    self.explosion = QuadImage:build("assets/explosion.png", 16, 16, 0)
    self.particles = QuadImage:build("assets/particles.png", 8, 8, 0)
    self.baddy1 = love.graphics.newImage("assets/baddy1.png")
end

function QuadImage:build(imagePath, width, height, space)
    local frames = {}
    local start = 0
    local image = love.graphics.newImage(imagePath)
    while start < image:getWidth() do
        table.insert(
            frames,
            love.graphics.newQuad(
                start,
                0,
                width,
                height,
                image:getWidth(),
                image:getHeight()
            )
        )
        start = start + width + space
    end

    local quadImage = QuadImage()
    quadImage.image = image
    quadImage.imageframes = frames
    quadImage.width = width
    quadImage.height = height
    return quadImage
end

function QuadImage:draw(frame, x, y)
    love.graphics.draw(self.image, self.imageframes[frame], x, y)
end

return Images
