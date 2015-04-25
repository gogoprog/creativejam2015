ComponentAutoRemove = {}

function ComponentAutoRemove:init()
    self.duration = self.duration or 1.5
end

function ComponentAutoRemove:insert()
end

function ComponentAutoRemove:update(dt)
    self.duration = self.duration - dt
    if self.duration < 0 then
        self.entity:remove()
    end
end

function ComponentAutoRemove:remove()
end
