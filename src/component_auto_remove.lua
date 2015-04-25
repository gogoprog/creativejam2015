ComponentAutoRemove = {}

function ComponentAutoRemove:init()
    self.duration = self.duration or 1.5
end

function ComponentAutoRemove:insert()
    self.timeLeft = self.duration
end

function ComponentAutoRemove:update(dt)
    self.timeLeft = self.timeLeft - dt
    if self.timeLeft < 0 then
        self.entity:remove()
    end
end

function ComponentAutoRemove:remove()
end
