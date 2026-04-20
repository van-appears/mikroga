Menu = Object:extend()

function Menu:update(dt)
    if love.keyboard.isDown("space") then
        STATE = "prepare"
    end
end

function Menu:draw()
    love.graphics.setFont(love.graphics.newFont(50))
    local font = love.graphics.getFont()

    local titleText = love.graphics.newText(font)
    titleText:add({{1,1,1}, "MIKROGA"}, 0, 0)
    love.graphics.draw(titleText, 10, 10)

    local startText = love.graphics.newText(font)
    startText:add({{1,1,1}, "PRESS SPACE TO START"}, 0, 0)
    love.graphics.draw(startText, 10, 110)

    local scoreText = love.graphics.newText(font)
    if Scoreboard:highscore() then
        local scorePrefix = Scoreboard:isChanged() and "NEW HIGHSCORE %d" or "HIGHSCORE %d"
        scoreText:add({{1,1,1}, string.format(scorePrefix, Scoreboard:highscore())}, 0, 0)
        love.graphics.draw(scoreText, 10, 210)
    end
end

return Menu
