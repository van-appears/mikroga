Images = Object:extend()

local QuadImage = Object:extend()

function Images:load()
    self.playerbullet = love.graphics.newImage("assets/mikroga_bullet.png")
    self.player = love.graphics.newImage("assets/mikroga_white.png")
    self.playerinvulnerable = love.graphics.newImage("assets/mikroga_invulnerable.png")
    self.life = love.graphics.newImage("assets/life.png")

    self.enemy1 = QuadImage:build("assets/enemy1.png", 64, 64, 1)
    self.enemy2 = QuadImage:build("assets/enemy2.png", 64, 64, 1)
    self.enemybullet = QuadImage:build("assets/enemy_bullet.png", 32, 32, 1)
    self.explosion = QuadImage:build("assets/explosion.png", 16, 16, 0)
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
