ComponentPlayer = {}

gengine.stateMachine(ComponentPlayer)

function ComponentPlayer:init()
    self:changeState("idling")
end

function ComponentPlayer:insert()
end

function ComponentPlayer:update(dt)
    self:updateState(dt)
end

function ComponentPlayer:remove()

end

function ComponentPlayer.onStateEnter:idling()
end

function ComponentPlayer.onStateUpdate:idling(dt)
    if Game.itIsPlayable then
        local keyboard = gengine.input.keyboard

        if keyboard:isDown(79) then
            self:tryMove(self.indices.x + 1, self.indices.y)
        end
        if keyboard:isDown(80) then
            self:tryMove(self.indices.x - 1, self.indices.y)
        end
        if keyboard:isDown(81) then
            self:tryMove(self.indices.x, self.indices.y - 1)
        end
        if keyboard:isDown(82) then
            self:tryMove(self.indices.x, self.indices.y + 1)
        end
    end
end

function ComponentPlayer.onStateExit:idling()
end

function ComponentPlayer.onStateEnter:moving()
    self.time = 0
    self.duration = 0.5

    self.startPosition = Map:getTilePosition(self.indices.x, self.indices.y)
    self.endPosition = Map:getTilePosition(self.target.x, self.target.y)

    local angle = gengine.math.getAngle(self.endPosition, self.startPosition)

    self.entity.rotation = angle + math.pi * 0.5
end

function ComponentPlayer.onStateUpdate:moving(dt)
    self.time = self.time + dt

    local factor = self.time / self.duration
    local done = false

    if factor >= 1 then
        factor = 1
        done = true
    end

    local f = ( 1.0 - math.cos( factor * math.pi ) ) * 0.5

    self.entity.position = self.startPosition + (self.endPosition - self.startPosition) * f

    if done then
        self.indices = self.target
        self:changeState("idling")
    end
end

function ComponentPlayer.onStateExit:moving()
end

function ComponentPlayer:tryMove(i, j)
    if not Map:isBlocking(i, j) then
        self.target = vector2(i, j)
        self:changeState("moving")
    end
end