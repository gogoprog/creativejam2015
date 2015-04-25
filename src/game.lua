require 'factory'
require 'map'

Game = Game or {
    objects = {}
}

gengine.stateMachine(Game)

function Game:init(dt)
    Factory:init()
    self.camera = Factory:createCamera()
    self.camera:insert()

    self.ground = Factory:createSprite("grass", 800, 800, 10)
    self.underground = Factory:createSprite("underground", 800, 800, -10)
end

function Game:finalize()
    for k, v in ipairs(self.objects) do
        v:remove()
    end

    self.objects = {}

    Factory:finalize()
    self.camera:remove()
    self.ground:remove()
    self.underground:remove()

    gengine.entity.destroy(self.camera)
    gengine.entity.destroy(self.ground)
    gengine.entity.destroy(self.underground)
end

function Game:update(dt)
    self:updateState(dt)
end

function Game.onStateEnter:none()
end

function Game.onStateUpdate:none(dt)
end

function Game.onStateExit:none()
end

function Game.onStateEnter:video()
    self.timeLeft = 1.0
    self.ground:insert()
end

function Game.onStateUpdate:video(dt)
    self.timeLeft = self.timeLeft - dt

    if self.timeLeft < 0 then
        self:changeState("blinking")
    end
end

function Game.onStateExit:video()
end

function Game.onStateEnter:blinking()
    self.time = 0
    self.underground:insert()
end

function Game.onStateUpdate:blinking(dt)
    self.time = self.time + dt

    local value = math.cos(self.time * 10) / 2 + 0.5

    self.ground.sprite.color = vector4(1,1,1, value)

    if self.time > 1 and value > 0.99 then
        self:changeState("playing")
    end
end

function Game.onStateExit:blinking()
end

function Game.onStateEnter:playing()
end

function Game.onStateUpdate:playing(dt)
    if gengine.input.keyboard:isJustUp(41) then
        Application:goToMenu()
    end
end

function Game.onStateExit:playing()
end

function Game:isRunning()
    return self.itIsRunning
end

function Game:start()
    self.itIsRunning = true
    Map:init()
    self:changeState("video")
end

function Game:stop()
    self:changeState("none")

    self.itIsRunning = false
    Map:finalize()
end