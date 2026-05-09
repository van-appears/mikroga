Game = Object:extend()

local Player
local PlayerBullet
local Enemy1
local Enemy2
local EnemyBullet
local EnemyPath
local Explosion
local Hud

function Game:load()
    PlayerBullet = require "src/playerbullet"
    Player = require "src/player"
    EnemyBullet = require "src/enemybullet"
    Enemy1 = require "src/enemy1"
    Enemy2 = require "src/enemy2"
    EnemyPath = require "src/enemypath"
    Explosion = require "src/explosion"
    Hud = require "src/hud"
end

function Game:prepare()
    self.enemies = {}
    self.playerBullets = {}
    self.enemyBullets = {}
    self.explosions = {}
    self.hits = {}

    self.player = Player()
    self.hud = Hud(self)
    self.deadNext = false
    self.counter = 0
    self.lives = 3
    self.score = 0

    table.insert(self.enemies, Game:randomEnemy())
    STATE = "playing"
end

function Game:update(dt)
    local newPlayerBullets = {}
    local newEnemyBullets = {}

    self.hits = {}
    self.counter = self.counter + dt
    self.player:update(dt, newPlayerBullets)

    if self.deadNext then
        Scoreboard:update(self.score)
        self.deadNext = false
        self:playerDied()
    end

    for i,v in ipairs(self.enemyBullets) do
        v:update(dt)
        if self.player:collided(v) then
            table.remove(self.enemyBullets, i)
            if v.colour == self.player.colour then
                self.score = self.score + 1
                v.colour = 4 -- magic number, fourth quad in enemy_bullet.png
                table.insert(self.hits, v)
            else
                self.deadNext = true
                v.colour = 3 -- magic number, third quad in enemy_bullet.png
                table.insert(self.hits, v)
            end
        elseif v.gone then
            table.remove(self.enemyBullets, i)
        end
    end

    for i,v in ipairs(self.playerBullets) do
        v:update(dt)
        if v.gone then
            table.remove(self.playerBullets, i)
        else
            for j,w in ipairs(self.enemies) do
                if v:collided(w) then
                    table.remove(self.playerBullets, i)
                    if v.colour == w.colour then
                        w.health = w.health - 1
                    else
                        w.health = w.health - 2
                    end

                    if w.health <= 0 then
                        self:createExplosions(w)
                        table.remove(self.enemies, j)
                        self.score = self.score + w.score
                    end
                end
            end
        end
    end

    for i,v in ipairs(self.explosions) do
        v:update(dt)
        if v.gone then
            table.remove(self.explosions, i)
        end
    end

    for i,v in ipairs(self.enemies) do
        v:update(dt, newEnemyBullets)
        if self.player:collided(v) then
            self.deadNext = true
            self:playerDied()
        elseif v.gone then
            table.remove(self.enemies, i)
        end
    end

    for i,v in ipairs(newEnemyBullets) do
        local bullet = EnemyBullet(EnemyPath:build(v, self.player), v.colour)
        table.insert(self.enemyBullets, bullet)
    end

    for i,v in ipairs(newPlayerBullets) do
        local bullet = PlayerBullet(v)
        table.insert(self.playerBullets, bullet)
    end

    if self.counter > 1.5 then
        table.insert(self.enemies, Game:randomEnemy())
        self.counter = self.counter - 1.5
    end
end

function Game:playerDied()
    self.lives = self.lives - 1
    if self.lives == 0 then
        STATE = "menu"
    else
        self.player:setInvulnerable()
    end
end

function Game:createExplosions(enemy)
    local paths = Explosion:buildPaths(enemy)
    for i,v in ipairs(paths) do
        table.insert(
            self.explosions,
            Explosion(EnemyPath:build(v))
        )
    end
end

function Game:randomEnemy()
    if math.random() < 0.5 then
        return Enemy1(EnemyPath:random())
    else
        return Enemy2(EnemyPath:random())
    end
end 

function Game:draw()
    for i,v in ipairs(self.explosions) do
        v:draw()
    end
    for i,v in ipairs(self.enemies) do
        v:draw()
    end
    for i,v in ipairs(self.enemyBullets) do
        v:draw()
    end
    for i,v in ipairs(self.playerBullets) do
        v:draw()
    end
    for i,v in ipairs(self.hits) do
        v:draw()
    end
    self.hud:draw()
    self.player:draw()
end

return Game
