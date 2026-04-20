Scoreboard = Object:extend()

local highscore
local changed

function Scoreboard:update(score)
    if score == 0 then
        changed = false
        return
    end
    if not highscore then
        highscore = score
        changed = true
    end
    if score > highscore then
        highscore = score
        changed = true
    end
end

function Scoreboard:isChanged()
    return changed
end

function Scoreboard:highscore()
    return highscore
end

return Scoreboard
