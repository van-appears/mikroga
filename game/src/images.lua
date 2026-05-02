Images = Object:extend()

function Images:load()
    self.playerbullet = love.graphics.newImage("assets/mikroga_bullet.png")
    self.player = love.graphics.newImage("assets/mikroga_white.png")
    self.playerinvulnerable = love.graphics.newImage("assets/mikroga_invulnerable.png")
    self.enemybullet = love.graphics.newImage("assets/enemy_bullet_white.png")
    self.enemy1 = love.graphics.newImage("assets/enemy1_white.png")
    self.enemy2 = love.graphics.newImage("assets/enemy2_white.png")
    self.life = love.graphics.newImage("assets/life.png")

    self.explosion = love.graphics.newImage("assets/explosion.png")
    self.explosionframes = {}
    self.explosionsize = 16
    for i=0,6 do
        table.insert(
            self.explosionframes,
            love.graphics.newQuad(
                self.explosionsize * i,
                0,
                self.explosionsize,
                self.explosionsize,
                self.explosion:getWidth(),
                self.explosion:getHeight()
            )
        )
    end
end

return Images
