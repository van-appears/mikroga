Game = Object:extend()

local Player
local PlayerBullet
local Enemy1
local Enemy2
local EnemyBullet
local EnemyPath

local score
local player
local enemies
local enemyBullets
local playerBullets
local counter
local font

function Game:load()
    PlayerBullet = require "src/playerbullet"
    Player = require "src/player"
    EnemyBullet = require "src/enemybullet"
    Enemy1 = require "src/enemy1"
    Enemy2 = require "src/enemy2"
    EnemyPath = require "src/enemypath"
end

function Game:prepare()
    love.graphics.setFont(love.graphics.newFont(20))
    font = love.graphics.getFont()

    player = Player()
    enemies = {}
    enemyBullets = {}
    playerBullets = {}
    counter = 0
    score = 0

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
            Scoreboard:update(score)
            STATE = "menu"
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
                        table.remove(enemies, j)
                        score = score + w.score
                    end
                end
            end
        end
    end

    for i,v in ipairs(enemies) do
        v:update(dt, newEnemyBullets)
        if player:collided(v) then
            Scoreboard:update(score)
            STATE = "menu"
        elseif v.gone then
            table.remove(enemies, i)
        end
    end

    for i,v in ipairs(newEnemyBullets) do
        local bullet = EnemyBullet(v)
        if bullet.setTarget then
            bullet:target(player)
        end
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

function Game:randomEnemy()
    if math.random() < 0.5 then
        return Enemy1(EnemyPath())
    else
        return Enemy2(EnemyPath())
    end
end 

function Game:draw()
    local scoreText = love.graphics.newText(font)
    scoreText:add({{1,1,1}, string.format("%d", score)}, 0, 0)
    love.graphics.draw(scoreText, 10, 10)

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
