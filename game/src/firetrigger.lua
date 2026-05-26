local FireTrigger = Object:extend()
local OnceTrigger = Object:extend()
local EveryTrigger = Object:extend()

function FireTrigger:once(timer, parent, fireMethod)
    return OnceTrigger(timer, parent, fireMethod)
end

function FireTrigger:every(timer, offset, parent, fireMethod)
    return EveryTrigger(timer, offset, parent, fireMethod)
end

function OnceTrigger:new(timer, parent, fireMethod)
    self.timer = timer
    self.parent = parent
    self.fireMethod = fireMethod
    self.counter = 0
    self.fired = false
end

function OnceTrigger:update(dt, newBullets)
    if not self.fired then
        self.counter = self.counter + dt
        if self.counter >= self.timer then
            self.fired = true
            local bullets = self.fireMethod(self.parent)
            if bullets then
                for i, v in ipairs(bullets) do
                    table.insert(newBullets, v)
                end
            end
        end
    end
end

function EveryTrigger:new(timer, offset, parent, fireMethod)
    self.timer = timer
    self.parent = parent
    self.fireMethod = fireMethod
    self.counter = offset
end

function EveryTrigger:update(dt, newBullets)
    if not self.fired then
        self.counter = self.counter + dt
        if self.counter >= self.timer then
            self.counter = self.counter - self.timer
            local bullets = self.fireMethod(self.parent)
            if bullets then
                for i, v in ipairs(bullets) do
                    table.insert(newBullets, v)
                end
            end
        end
    end
end

return FireTrigger
