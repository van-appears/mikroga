local Level1 = Object:extend()

function Level1:new()
    self.counter = 0
    self.particleQuad = Images.particles
    self.particles = {}
    self.planetImage = Images.planet
    self.planetHeight = self.planetImage:getHeight()
    self.planetY = -self.planetHeight * 3 / 2
    self:createStars()

    self.launchIndex = 1
    self.launch = {
        -- time, type, colour, x, y, speed
        { 3.5, TARGETER, WHITE, DROP, 370, 100 },
        { 4.1, TARGETER, WHITE, DROP, 300, 110 },
        { 4.1, TARGETER, WHITE, DROP, 440, 110 },
        { 5.0, SPREADER, BLACK, DROP, 500, 100 },
        { 5.5, SPREADER, BLACK, DROP, 550, 120 },
        { 6.0, SPREADER, BLACK, DROP, 600, 140 },
        { 6.5, SPREADER, BLACK, DROP, 650, 160 },

        { 7.8, TARGETER, WHITE, STRAFE_LEFT, 100, 100 },
        { 8.5, TARGETER, BLACK, STRAFE_RIGHT, 170, 110 },
        { 9.2, SPREADER, WHITE, STRAFE_LEFT, 240, 120 },
        { 9.9, SPREADER, BLACK, STRAFE_RIGHT, 310, 130 },
        { 10.6, TARGETER, WHITE, STRAFE_LEFT, 100, 130 },
        { 11.3, TARGETER, BLACK, STRAFE_LEFT, 170, 120 },
        { 12.0, SPREADER, WHITE, STRAFE_RIGHT, 240, 110 },
        { 12.7, SPREADER, BLACK, STRAFE_RIGHT, 310, 100 },

        { 13.0, TARGETER, WHITE, DROP, 500, 110 },
        { 13.5, TARGETER, WHITE, DROP, 600, 120 },
        { 14.0, SPREADER, WHITE, DROP, 500, 110 },
        { 14.5, SPREADER, WHITE, DROP, 600, 120 },
        { 15.0, SPREADER, BLACK, DROP, 100, 110 },
        { 15.5, SPREADER, BLACK, DROP, 200, 120 },
        { 16.0, SPREADER, BLACK, DROP, 100, 110 },
        { 16.5, SPREADER, BLACK, DROP, 200, 120 },

        { 17.8, TARGETER, WHITE, CURVED, 100, 150, 500, 3.0 },
        { 18.5, TARGETER, BLACK, CURVED, 100, 150, 500, 3.0 },
        { 19.2, SPREADER, WHITE, CURVED, 100, 150, 500, 3.0 },
        { 19.9, SPREADER, BLACK, CURVED, 100, 150, 500, 3.0 },
        { 20.5, TARGETER, WHITE, CURVED, 100, 150, 500, 3.0 },
        { 20.6, TARGETER, WHITE, CURVED, 100, 150, 500, 3.0 },
        { 21.1, TARGETER, WHITE, CURVED, 100, 150, 500, 3.0 },
        { 21.1, TARGETER, WHITE, CURVED, 100, 150, 500, 3.0 },
        { 21.3, TARGETER, BLACK, CURVED, 100, 150, 500, 3.0 },
        { 22.0, SPREADER, WHITE, CURVED, 100, 150, 500, 3.0 },
        { 22.7, SPREADER, BLACK, CURVED, 100, 150, 500, 3.0 },

        { 24.0, SPREADER, BLACK, DROP, 500, 100 },
        { 24.5, SPREADER, BLACK, DROP, 550, 120 },
        { 25.0, SPREADER, BLACK, DROP, 600, 140 },
        { 25.5, SPREADER, BLACK, DROP, 650, 160 },
        { 26.0, SPREADER, WHITE, DROP, 100, 100 },
        { 26.5, SPREADER, WHITE, DROP, 150, 120 },
        { 27.0, SPREADER, WHITE, DROP, 200, 140 },
        { 27.5, SPREADER, WHITE, DROP, 250, 160 },

        { 29.0, SPREADER, WHITE, CURVED, 100, 100, 100, 4.0 },
        { 29.0, SPREADER, WHITE, CURVED, 100, 100, 150, 4.0 },
        { 29.0, SPREADER, WHITE, CURVED, 100, 100, 200, 4.0 },
        { 29.0, SPREADER, WHITE, CURVED, 100, 100, 250, 4.0 },

        { 32.0, SPREADER, BLACK, CURVED, 600, 100, -100, 4.0 },
        { 32.0, SPREADER, BLACK, CURVED, 600, 100, -150, 4.0 },
        { 32.0, SPREADER, BLACK, CURVED, 600, 100, -200, 4.0 },
        { 32.0, SPREADER, BLACK, CURVED, 600, 100, -250, 4.0 },

        { 33.5, TARGETER, WHITE, DROP, 370, 100 },
        { 34.1, TARGETER, WHITE, DROP, 300, 110 },
        { 34.1, TARGETER, WHITE, DROP, 440, 110 },
        { 35.0, SPREADER, BLACK, DROP, 500, 100 },
        { 35.5, SPREADER, BLACK, DROP, 550, 120 },
        { 36.0, SPREADER, BLACK, DROP, 600, 140 },
        { 36.5, SPREADER, BLACK, DROP, 650, 160 },

        { 37.8, TARGETER, WHITE, DROP, 700, 170 },
        { 38.5, TARGETER, BLACK, STRAFE_LEFT, 150, 130 },
        { 39.2, SPREADER, WHITE, CURVED, 50, 130, 200, 3.0 },
        { 39.9, SPREADER, BLACK, DROP, 300, 130 },
        { 40.6, TARGETER, WHITE, DROP, 400, 140 },
        { 41.3, TARGETER, BLACK, CURVED, 700, 130, -200, 3.0 },
        { 42.0, SPREADER, WHITE, STRAFE_RIGHT, 200, 130 },
        { 42.7, SPREADER, BLACK, DROP, 50, 170 },

        { 43.0, TARGETER, WHITE, DROP, 700, 110 },
        { 43.5, TARGETER, WHITE, DROP, 600, 120 },
        { 44.0, SPREADER, WHITE, DROP, 700, 110 },
        { 44.5, SPREADER, WHITE, DROP, 600, 120 },
        { 45.0, SPREADER, BLACK, DROP, 100, 110 },
        { 45.5, SPREADER, BLACK, DROP, 200, 120 },
        { 46.0, SPREADER, BLACK, DROP, 100, 110 },
        { 46.5, SPREADER, BLACK, DROP, 200, 120 },

        { 47.8, TARGETER, WHITE, STRAFE_LEFT, 0, 170 },
        { 48.5, TARGETER, BLACK, STRAFE_RIGHT, 100, 160 },
        { 49.2, SPREADER, WHITE, STRAFE_LEFT, 200, 150 },
        { 49.9, SPREADER, BLACK, STRAFE_RIGHT, 300, 140 },
        { 50.5, TARGETER, WHITE, STRAFE_LEFT, 400, 130 },
        { 50.6, TARGETER, WHITE, STRAFE_RIGHT, 400, 130 },
        { 51.1, TARGETER, WHITE, STRAFE_LEFT, 300, 140 },
        { 51.1, TARGETER, WHITE, STRAFE_RIGHT, 200, 150 },
        { 51.3, TARGETER, BLACK, STRAFE_LEFT, 100, 160 },
        { 52.0, SPREADER, WHITE, STRAFE_RIGHT, 0, 170 },

        { 54.0, SPREADER, BLACK, CURVED, 100, 130, 100, 1.0 },
        { 54.5, SPREADER, BLACK, CURVED, 200, 130, 100, 1.0 },
        { 55.0, SPREADER, BLACK, CURVED, 300, 130, 100, 1.0 },
        { 55.5, SPREADER, BLACK, CURVED, 400, 130, 100, 1.0 },
        { 56.0, SPREADER, WHITE, CURVED, 500, 130, 100, 1.0 },
        { 56.5, SPREADER, WHITE, CURVED, 600, 130, 100, 1.0 },
        { 57.0, SPREADER, WHITE, CURVED, 300, 130, -300, 2.0 },
        { 57.5, SPREADER, WHITE, CURVED, 650, 130, -300, 2.0 },

        { 60.0, BADDY1, nil, BADDY, nil, nil, nil }
    }
end

function Level1:createStars()
    for c = 1, WINDOW_HEIGHT do
        self:createStar()
        for i,v in ipairs(self.particles) do
            v[2] = v[2] + 10 * 0.1 * v[4]
        end
    end
end

function Level1:createStar()
    if love.math.random() < 0.1 then
        local x = love.math.random(WINDOW_WIDTH - 16)
        local y = -10
        local type = math.random(6)
        local speed = (8 - type) + love.math.random() / 2
        table.insert(self.particles, { x, y, type, speed })
    end
end

function Level1:update(dt, newEnemies)
    self.counter = self.counter + dt
    self.planetY = self.planetY + dt * 20
    self:createStar()

    for i,v in ipairs(self.particles) do
        v[2] = v[2] + 10 * dt * v[4]
        if v[2] > WINDOW_HEIGHT then
            table.remove(self.particles, i)
        end
    end

    local nextItem = self.launch[self.launchIndex]
    while nextItem ~= nil and nextItem[1] < self.counter do
        table.insert(newEnemies, nextItem)
        self.launchIndex = self.launchIndex + 1
        nextItem = self.launch[self.launchIndex]
    end
end

function Level1:draw()
    love.graphics.draw(self.planetImage, WINDOW_WIDTH - 300, self.planetY)
    for i,v in ipairs(self.particles) do
        self.particleQuad:draw(v[3], v[1], v[2])
    end
end

return Level1
