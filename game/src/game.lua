Game = Object:extend()

local Player
local PlayerBullet
local Enemy1
local Enemy2
local EnemyBullet
local EnemyPath
local Explosion
local Hud
local Level1

function Game:load()
    PlayerBullet = require "src/playerbullet"
    Player = require "src/player"
    EnemyBullet = require "src/enemybullet"
    Enemy1 = require "src/enemy1"
    Enemy2 = require "src/enemy2"
    EnemyPath = require "src/enemypath"
    Explosion = require "src/explosion"
    Hud = require "src/hud"
    Level1 = require "src/level1"
end

function Game:prepare()
    self.enemies = {}
    self.playerBullets = {}
    self.enemyBullets = {}
    self.explosions = {}
    self.hits = {}

    self.hud = Hud(self)
    self.player = Player()
    self.level = Level1()
    self.deadNext = false
    self.counter = 0
    self.endCounter = 0
    self.lives = 3
    self.score = 0

    STATE = "begin"
end

function Game:update(dt)
    local newPlayerBullets = {}
    local newEnemyBullets = {}
    local newEnemies = {}

    self.deadNext = false
    self.hits = {}
    self.counter = self.counter + dt
    if self.lives > 0 then
        if STATE == "begin" then
            local yAdjust = 1 - math.cos(2 * self.counter * math.pi / 3) + (self.counter / 3)
            self.player.y = WINDOW_HEIGHT + 100 - yAdjust * 200
            if self.counter > 3 then
                STATE = "playing"
            end
        elseif STATE == "completed" then
            self.endCounter = self.endCounter + dt
            local yAdjust = math.sin(0.5 * self.endCounter * math.pi / 3)
            self.player.y = self.player.y - yAdjust * 200
            if self.endCounter > 3 then
                Scoreboard:update(self.score)
                STATE = "menu"
            end
        else
            self.player:update(dt, newPlayerBullets)
        end
    else
        self.endCounter = self.endCounter + dt
        if self.endCounter > 5 then
            Scoreboard:update(self.score)
            STATE = "menu"
        end
    end

    for i,v in ipairs(self.enemyBullets) do
        v:update(dt)
        if not self.deadNext and self.lives > 0 and self.player:collided(v) then
            table.remove(self.enemyBullets, i)
            if v.colour == self.player.colour then
                v.colour = 4
                self.score = self.score + 1
                table.insert(self.hits, v)
            else
                v.colour = 3 -- magic number, third quad in enemy_bullet.png
                table.insert(self.hits, v)
                self:playerDied()
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
        if not self.deadNext and self.lives > 0 and self.player:collided(v) then
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

    self.level:update(dt, newEnemies)
    for i,v in ipairs(newEnemies) do
        if v[2] == 0 then
            STATE = "completed"
        else
            local enemy = self:createEnemy(v)
            table.insert(self.enemies, enemy)
        end
    end
end

function Game:playerDied()
    self.deadNext = true
    self.lives = self.lives - 1
    if self.lives == 0 then
        STATE = "death"
        self:createExplosions(self.player)
    else
        self.player:setInvulnerable()
    end
end

function Game:createExplosions(source)
    local paths = Explosion:buildPaths(source)
    for i,v in ipairs(paths) do
        table.insert(
            self.explosions,
            Explosion(EnemyPath:build(v))
        )
    end
end

function Game:createEnemy(table)
    local enemy = nil
    local path = nil
    if table[4] == DROP then
        path = EnemyPath:drop(table[5], table[6])
    elseif table[4] == STRAFE_LEFT then
        path = EnemyPath:strafeLeft(table[5], table[6])
    elseif table[4] == STRAFE_RIGHT then
        path = EnemyPath:strafeRight(table[5], table[6])
    elseif table[4] == CURVED then
        path = EnemyPath:curvedDrop(table[5], table[6], table[7], table[8])
    end
    if table[2] == 1 then
        enemy = Enemy1(path)
    else
        enemy = Enemy2(path)
    end
    enemy.colour = table[3]
    return enemy
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
    if self.lives > 0 then
        self.player:draw()
    end
    self.hud:draw()
end

return Game
