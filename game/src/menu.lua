Menu = Object:extend()

local font

function Menu:prepare()
    love.graphics.setFont(love.graphics.newFont(50))
    font = love.graphics.getFont()
end

function Menu:update(dt)
    if love.keyboard.isDown("space") then
        STATE = "prepare"
    end
end

function Menu:draw()
    local titleText = love.graphics.newText(font)
    titleText:add({{1,1,1}, "MIKROGA"}, 0, 0)
    love.graphics.draw(titleText, 10, 10)

    local startText = love.graphics.newText(font)
    startText:add({{1,1,1}, "PRESS SPACE TO START"}, 0, 0)
    love.graphics.draw(startText, 10, 100)
end

return Menu
