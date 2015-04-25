ComponentPlayer = {
    startMousePosition = nil
}

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

    self.entity.sprite:removeAnimations()
    self.entity.sprite:pushAnimation(Factory.animations.idle)

    if self.indices == Map.endPositionIndices then
        Game:changeState("winning")
    end
end

function ComponentPlayer.onStateUpdate:idling(dt)
    if Game.itIsPlayable then
        local keyboard = gengine.input.keyboard
        local mouse = gengine.input.mouse
        local start_position = vector2( 0, 0 )

        if keyboard:isDown(79) then
            self:tryMove(self.indices.x + 1, self.indices.y)
        elseif keyboard:isDown(80) then
            self:tryMove(self.indices.x - 1, self.indices.y)
        elseif keyboard:isDown(81) then
            self:tryMove(self.indices.x, self.indices.y - 1)
        elseif keyboard:isDown(82) then
            self:tryMove(self.indices.x, self.indices.y + 1)
        end

        if mouse:isJustDown(1) then
            startMousePosition = mouse:getPosition() 
        end
        if mouse:isDown(1) then 
            if startMousePosition.x < mouse:getPosition(1).x and mouse:getPosition(1).x - startMousePosition.x > 100 then 
                self:tryMove(self.indices.x + 1, self.indices.y)
            elseif startMousePosition.x > mouse:getPosition(1).x and startMousePosition.x - mouse:getPosition(1).x > 100 then  
                self:tryMove(self.indices.x - 1, self.indices.y)
            elseif startMousePosition.y < mouse:getPosition(1).y and mouse:getPosition(1).y - startMousePosition.y > 100 then  
                self:tryMove(self.indices.x, self.indices.y - 1)
            elseif startMousePosition.y > mouse:getPosition(1).y and startMousePosition.y - mouse:getPosition(1).y > 100 then 
                self:tryMove(self.indices.x, self.indices.y + 1)
            end
        end
    end
end

function ComponentPlayer.onStateExit:idling()
end

function ComponentPlayer.onStateEnter:moving()
    self.entity.sprite:removeAnimations()
    self.entity.sprite:pushAnimation(Factory.animations.dig)

    self.time = 0
    self.duration = 0.5

    self.startPosition = Map:getTilePosition(self.indices.x, self.indices.y)
    self.endPosition = Map:getTilePosition(self.target.x, self.target.y)
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

function ComponentPlayer.onStateEnter:shaking()
    self.duration = 0.5

end

function ComponentPlayer.onStateUpdate:shaking(dt)
    self.duration = self.duration - dt

    if self.duration < 0 then
        self:changeState("idling")
    end
end

function ComponentPlayer.onStateExit:shaking()
end


function ComponentPlayer:tryMove(i, j)

    local a = Map:getTilePosition(self.indices.x, self.indices.y)
    local b = Map:getTilePosition(i, j)

    local angle = gengine.math.getAngle(b, a)

    self.entity.rotation = angle + math.pi * 0.5

    if not Map:isBlocking(i, j) then
        self.target = vector2(i, j)
        self:changeState("moving")
    else
        local e = Factory:createCollisionParticle()
        e.position = b
        e:insert()
        Game.camera.shaker:shake(0.5)
    end
end