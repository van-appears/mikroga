Images = Object:extend()

function Images:load()
    self.playerbullet = love.graphics.newImage("assets/mikroga_bullet.png")
    self.player = love.graphics.newImage("assets/mikroga_white.png")
    self.enemybullet = love.graphics.newImage("assets/enemy_bullet_white.png")
    self.enemy1 = love.graphics.newImage("assets/enemy1_white.png")
end

return Images
