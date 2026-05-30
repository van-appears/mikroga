Game = Object:extend()

local Player
local PlayerBullet
local Baddy1
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
    Baddy1 = require "src/baddy1"
    Enemy1 = require "src/enemy1"
    Enemy2 = require "src/enemy2"
    EnemyPath = require "src/enemypath"
    Explosion = require "src/explosion"
    Hud = require "src/hud"
    Level1 = require "src/level1"
end

function Game:prepare()
    self.enemies = {}
    self.newEnemies = {}
    self.playerBullets = {}
    self.newPlayerBullets = {}
    self.enemyBullets = {}
    self.newEnemyBullets = {}
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
            if self.endCounter > 1 then
                local yAdjust = math.sin(0.5 * (self.endCounter - 1) * math.pi / 3)
                self.player.y = self.player.y - yAdjust * 200
            end
            if self.endCounter > 4 then
                Scoreboard:update(self.score)
                STATE = "menu"
            end
        else
            self.player:update(dt, self.newPlayerBullets)
        end
    else
        self.endCounter = self.endCounter + dt
        if self.endCounter > 5 then
            Scoreboard:update(self.score)
            STATE = "menu"
        end
    end

    self:updateTable(self.enemyBullets, dt, self.updateEnemyBullet)
    self:updateTable(self.playerBullets, dt, self.updatePlayerBullet)
    self:updateTable(self.explosions, dt, self.updateExplosion)
    self:updateTable(self.enemies, dt, self.updateEnemy)

    for i,v in ipairs(self.newEnemyBullets) do
        local bullet = EnemyBullet(EnemyPath:defined(v, self.player), v.colour)
        table.insert(self.enemyBullets, bullet)
        self.newEnemyBullets[i] = nil
    end

    for i,v in ipairs(self.newPlayerBullets) do
        local bullet = PlayerBullet(v)
        table.insert(self.playerBullets, bullet)
        self.newPlayerBullets[i] = nil
    end

    self.level:update(dt, self.newEnemies)
    for i,v in ipairs(self.newEnemies) do
        local enemy = self:createEnemy(v)
        table.insert(self.enemies, enemy)
        self.newEnemies[i] = nil
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
            Explosion(v)
        )
    end
end

function Game:updateTable(myTable, dt, updateFn)
    if #myTable == 0 then
        return
    end

    local i = 1
    local last = 1
    while myTable[i] do
        if updateFn(self, myTable[i], dt) then
            if (i ~= last) then
                myTable[last] = myTable[i]
                myTable[i] = nil
            end
            last = last + 1
        else
            myTable[i] = nil
        end
        i = i + 1
    end
end

function Game:updateEnemyBullet(bullet, dt)
    bullet:update(dt)
    if bullet.gone then
        return false
    end
    if not self.deadNext and self.lives > 0 and self.player:collided(bullet) then
        if bullet.colour == self.player.colour then
            bullet.colour = 4
            self.score = self.score + 1
            table.insert(self.hits, bullet)
        else
            bullet.colour = 3
            table.insert(self.hits, bullet)
            self:playerDied()
        end
        return false
    end
    return true
end

function Game:updateEnemy(enemy, dt)
    enemy:update(dt, self.newEnemyBullets)
    if not self.deadNext and self.lives > 0 and self.player:collided(enemy) then
        self:playerDied()
    elseif enemy.gone then
        return false
    end
    return true
end

function Game:updatePlayerBullet(bullet, dt)
    bullet:update(dt)
    if bullet.gone then
        return false
    end

    for i,v in ipairs(self.enemies) do
        if bullet:collided(v) then
            if bullet.colour == v.colour then
                v.health = v.health - 1
            else
                v.health = v.health - 2
            end

            if v.health <= 0 then
                v.gone = true
                self:createExplosions(v)
                self.score = self.score + v.score
                if v.type == BADDY1 then
                    STATE = "completed"
                end
            end
            return false
        end
    end
    return true
end

function Game:updateExplosion(explosion, dt)
    explosion:update(dt)
    return not explosion.gone
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

    if table[2] == BADDY1 then
        enemy = Baddy1()
    elseif table[2] == TARGETER then
        enemy = Enemy1(path)
        enemy.colour = table[3]
    elseif table[3] == SPREADER then
        enemy = Enemy2(path)
        enemy.colour = table[3]
    end

    return enemy
end

function Game:draw()
    self.level:draw()
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
