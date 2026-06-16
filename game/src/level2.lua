local Level2 = Object:extend()

function Level2:new()
    self.counter = 0
    self.cloudQuad = Images.clouds
    self.clouds = {}
    self:createClouds()

    self.launchIndex = 1
    self.launch = {
        -- time, type, colour, x, y, speed
        { 3.5, TARGETER, WHITE, DROP, 100, 130 },
        { 4.1, TARGETER, BLACK, DROP, 650, 130 },
        { 4.1, TARGETER, WHITE, DROP, 200, 130 },
        { 5.0, TARGETER, BLACK, DROP, 550, 130 },
        { 5.5, TARGETER, WHITE, DROP, 300, 130 },
        { 6.0, TARGETER, BLACK, DROP, 450, 130 },

        { 6.6, FORWARDER, WHITE, DROP, 600, 100 },
        { 7.2, FORWARDER, BLACK, DROP, 500, 120 },
        { 7.8, FORWARDER, WHITE, DROP, 400, 140 },
        { 8.4, FORWARDER, BLACK, DROP, 300, 160 },
        { 9.0, FORWARDER, WHITE, DROP, 200, 180 },

        { 10.6, SPREADER, WHITE, TWEEN, 3, 100,
            -100, 100,
            100, 100,
            400, 400,
            200, WINDOW_HEIGHT + 100 },
        { 11.3, SPREADER, WHITE, TWEEN, 3, 100,
            WINDOW_WIDTH + 100, 100,
            WINDOW_WIDTH - 100, 100,
            WINDOW_WIDTH - 400, 400,
            WINDOW_WIDTH - 200, WINDOW_HEIGHT + 100 },
        { 12.0, SPREADER, BLACK, TWEEN, 3, 100,
            -100, 100,
            100, 100,
            500, 400,
            300, WINDOW_HEIGHT + 100 },
        { 12.7, SPREADER, BLACK, TWEEN, 3, 100,
            WINDOW_WIDTH + 100, 100,
            WINDOW_WIDTH - 100, 100,
            WINDOW_WIDTH - 500, 400,
            WINDOW_WIDTH - 300, WINDOW_HEIGHT + 100 },

        { 13.0, TARGETER, WHITE, DROP, 500, 110 },
        { 13.5, TARGETER, WHITE, DROP, 600, 120 },
        { 14.0, SPREADER, WHITE, DROP, 500, 110 },
        { 14.5, SPREADER, WHITE, DROP, 600, 120 },
        { 15.0, SPREADER, BLACK, DROP, 100, 110 },
        { 15.5, SPREADER, BLACK, DROP, 200, 120 },
        { 16.0, TARGETER, BLACK, DROP, 100, 110 },
        { 16.5, TARGETER, BLACK, DROP, 200, 120 },

        { 17.8, FORWARDER, WHITE, CURVED, 100, 150, 500, 3.0 },
        { 18.5, FORWARDER, WHITE, CURVED, 100, 150, 500, 3.0 },
        { 19.2, TARGETER, WHITE, TWEEN, 3, 100,
            -100, 100,
            100, 100,
            400, 400,
            200, WINDOW_HEIGHT + 100 },
        { 19.9, TARGETER, WHITE, TWEEN, 3, 100,
            WINDOW_WIDTH + 100, 100,
            WINDOW_WIDTH - 100, 100,
            WINDOW_WIDTH - 400, 400,
            WINDOW_WIDTH - 200, WINDOW_HEIGHT + 100 },
        { 20.6, TARGETER, BLACK, TWEEN, 3, 100,
            -100, 100,
            100, 100,
            500, 400,
            300, WINDOW_HEIGHT + 100 },
        { 21.3, TARGETER, BLACK, TWEEN, 3, 100,
            WINDOW_WIDTH + 100, 100,
            WINDOW_WIDTH - 100, 100,
            WINDOW_WIDTH - 500, 400,
            WINDOW_WIDTH - 300, WINDOW_HEIGHT + 100 },
        { 22.0, FORWARDER, BLACK, CURVED, 100, 150, 500, 3.0 },
        { 22.7, FORWARDER, BLACK, CURVED, 100, 150, 500, 3.0 },

        { 24.0, FORWARDER, BLACK, DROP, 500, 100 },
        { 24.5, FORWARDER, BLACK, DROP, 550, 120 },
        { 25.0, FORWARDER, BLACK, DROP, 600, 140 },
        { 25.5, FORWARDER, BLACK, DROP, 650, 160 },
        { 26.0, FORWARDER, WHITE, DROP, 100, 100 },
        { 26.5, FORWARDER, WHITE, DROP, 150, 120 },
        { 27.0, FORWARDER, WHITE, DROP, 200, 140 },
        { 27.5, FORWARDER, WHITE, DROP, 250, 160 },

        { 29.0, SPREADER, WHITE, CURVED, 100, 100, 100, 4.0 },
        { 29.0, SPREADER, WHITE, CURVED, 100, 100, 150, 4.0 },
        { 29.0, SPREADER, WHITE, CURVED, 100, 100, 200, 4.0 },
        { 29.0, SPREADER, WHITE, CURVED, 100, 100, 250, 4.0 },

        { 32.0, TARGETER, WHITE, DROP, 370, 100 },
        { 32.0, TARGETER, WHITE, DROP, 300, 110 },
        { 32.0, TARGETER, WHITE, DROP, 440, 110 },
        { 32.0, TARGETER, BLACK, DROP, 500, 100 },
        { 32.0, TARGETER, BLACK, DROP, 550, 120 },
        { 32.0, TARGETER, BLACK, DROP, 600, 140 },
        { 32.0, TARGETER, BLACK, DROP, 650, 160 },

        { 34.5, SPREADER, BLACK, CURVED, 600, 100, -100, 4.0 },
        { 35.0, SPREADER, BLACK, CURVED, 600, 100, -150, 4.0 },
        { 35.5, SPREADER, BLACK, CURVED, 600, 100, -200, 4.0 },
        { 36.0, SPREADER, BLACK, CURVED, 600, 100, -250, 4.0 },

        { 37.8, TARGETER, WHITE, DROP, 700, 170 },
        { 38.5, TARGETER, BLACK, STRAFE_LEFT, 150, 130 },
        { 39.2, SPREADER, WHITE, CURVED, 50, 130, 200, 3.0 },
        { 39.9, SPREADER, BLACK, DROP, 300, 130 },
        { 40.6, TARGETER, WHITE, DROP, 400, 140 },
        { 41.3, TARGETER, BLACK, CURVED, 700, 130, -200, 3.0 },
        { 42.0, SPREADER, WHITE, STRAFE_RIGHT, 200, 130 },
        { 42.7, SPREADER, BLACK, DROP, 50, 170 },

        { 43.0, TARGETER, WHITE, DROP, 700, 110 },
        { 43.5, SPREADER, WHITE, DROP, 600, 120 },
        { 44.0, FORWARDER, WHITE, DROP, 700, 110 },
        { 44.5, FORWARDER, WHITE, DROP, 600, 120 },
        { 45.0, TARGETER, BLACK, DROP, 100, 110 },
        { 45.5, SPREADER, BLACK, DROP, 200, 120 },
        { 46.0, FORWARDER, BLACK, DROP, 100, 110 },
        { 46.5, FORWARDER, BLACK, DROP, 200, 120 },

        { 47.8, SPREADER, BLACK, CURVED, 100, 130, 100, 1.0 },
        { 48.5, SPREADER, BLACK, CURVED, 200, 130, 100, 1.0 },
        { 49.2, SPREADER, BLACK, CURVED, 300, 130, 100, 1.0 },
        { 49.9, SPREADER, BLACK, CURVED, 400, 130, 100, 1.0 },
        { 50.6, FORWARDER, WHITE, CURVED, 500, 130, 100, 1.0 },
        { 51.3, FORWARDER, WHITE, CURVED, 600, 130, 100, 1.0 },
        { 52.0, FORWARDER, WHITE, CURVED, 300, 130, -300, 2.0 },
        { 52.7, FORWARDER, WHITE, CURVED, 650, 130, -300, 2.0 },

        { 54.0, FORWARDER, WHITE, CURVED, 100, 150, 500, 3.0 },
        { 54.5, FORWARDER, WHITE, CURVED, 100, 150, 500, 3.0 },
        { 55.0, TARGETER, WHITE, TWEEN, 3, 100,
            -100, 100,
            100, 100,
            400, 400,
            200, WINDOW_HEIGHT + 100 },
        { 55.5, TARGETER, WHITE, TWEEN, 3, 100,
            WINDOW_WIDTH + 100, 100,
            WINDOW_WIDTH - 100, 100,
            WINDOW_WIDTH - 400, 400,
            WINDOW_WIDTH - 200, WINDOW_HEIGHT + 100 },
        { 56.0, TARGETER, BLACK, TWEEN, 3, 100,
            -100, 100,
            100, 100,
            500, 400,
            300, WINDOW_HEIGHT + 100 },
        { 56.5, TARGETER, BLACK, TWEEN, 3, 100,
            WINDOW_WIDTH + 100, 100,
            WINDOW_WIDTH - 100, 100,
            WINDOW_WIDTH - 500, 400,
            WINDOW_WIDTH - 300, WINDOW_HEIGHT + 100 },
        { 57.0, FORWARDER, BLACK, CURVED, 100, 150, 500, 3.0 },
        { 57.5, FORWARDER, BLACK, CURVED, 100, 150, 500, 3.0 },

        { 60.0, BADDY2, nil, INTERNAL, nil, nil, nil }
    }
end

function Level2:createClouds()
    for c = 1, WINDOW_HEIGHT do
        self:createCloud()
        for i,v in ipairs(self.clouds) do
            v[2] = v[2] + v[4] * 0.1
        end
    end
end

function Level2:createCloud()
    if love.math.random() < 0.4 then
        local x = love.math.random(WINDOW_WIDTH + 64) - 64
        local y = -128
        local type = math.random(8)
        local speed = math.random(5, 10)
        table.insert(self.clouds, { x, y, type, speed })
    end
end

function Level2:update(dt, newEnemies)
    self.counter = self.counter + dt
    self:createCloud()

    for i,v in ipairs(self.clouds) do
        v[2] = v[2] + 10 * dt * v[4]
        if v[2] > WINDOW_HEIGHT then
            table.remove(self.clouds, i)
        end
    end

    local nextItem = self.launch[self.launchIndex]
    while nextItem ~= nil and nextItem[1] < self.counter do
        table.insert(newEnemies, nextItem)
        self.launchIndex = self.launchIndex + 1
        nextItem = self.launch[self.launchIndex]
    end
end

function Level2:draw()
    for i,v in ipairs(self.clouds) do
        self.cloudQuad:draw(v[3], v[1], math.floor(v[2]))
    end
end

return Level2
