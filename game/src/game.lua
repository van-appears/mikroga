Game = Object:extend()

local Player
local PlayerBullet
local Enemy1
local Enemy2
local EnemyBullet
local EnemyPath
local Explosion
local Hud

local player
local enemies
local enemyBullets
local playerBullets
local counter
local explosions

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
    player = Player()
    enemies = {}
    enemyBullets = {}
    playerBullets = {}
    explosions = {}
    counter = 0

    self.lives = 3
    self.score = 0
    self.hud = Hud(self)

    table.insert(enemies, Game:randomEnemy())
    STATE = "playing"
end

function Game:update(dt)
    counter = counter + dt
    local newPlayerBullets = {}
    local newEnemyBullets = {}
    player:update(dt, newPlayerBullets)

    for i,v in ipairs(enemyBullets) do
        v:update(dt)
        if player:collided(v) then
            Scoreboard:update(self.score)
            self:playerDied()
        elseif v.gone then
            table.remove(enemyBullets, i)
        end
    end

    for i,v in ipairs(playerBullets) do
        v:update(dt)
        if v.gone then
            table.remove(playerBullets, i)
        else
            for j,w in ipairs(enemies) do
                if v:collided(w) then
                    table.remove(playerBullets, i)
                    w.health = w.health - 1
                    if w.health <= 0 then
                        self:createExplosions(w)
                        table.remove(enemies, j)
                        self.score = self.score + w.score
                    end
                end
            end
        end
    end

    for i,v in ipairs(explosions) do
        v:update(dt)
        if v.gone then
            table.remove(explosions, i)
        end
    end

    for i,v in ipairs(enemies) do
        v:update(dt, newEnemyBullets)
        if player:collided(v) then
            Scoreboard:update(self.score)
            self:playerDied()
        elseif v.gone then
            table.remove(enemies, i)
        end
    end

    for i,v in ipairs(newEnemyBullets) do
        local bullet = EnemyBullet(EnemyPath:build(v, player))
        table.insert(enemyBullets, bullet)
    end

    for i,v in ipairs(newPlayerBullets) do
        local bullet = PlayerBullet(v)
        table.insert(playerBullets, bullet)
    end

    if counter > 1.5 then
        table.insert(enemies, Game:randomEnemy())
        counter = counter - 1.5
    end
end

function Game:playerDied()
    self.lives = self.lives - 1
    if self.lives == 0 then
        STATE = "menu"
    else
        player:setInvulnerable()
    end
end

function Game:createExplosions(enemy)
    local paths = Explosion:buildPaths(enemy)
    for i,v in ipairs(paths) do
        table.insert(
            explosions,
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
    self.hud:draw()
    for i,v in ipairs(explosions) do
        v:draw()
    end
    for i,v in ipairs(enemies) do
        v:draw()
    end
    for i,v in ipairs(enemyBullets) do
        v:draw()
    end
    for i,v in ipairs(playerBullets) do
        v:draw()
    end

    player:draw()
end

return Game
