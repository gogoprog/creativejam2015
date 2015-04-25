require 'factory'
require 'map'

Game = Game or {
    objects = {}
}

gengine.stateMachine(Game)

function Game:init(dt)
    Factory:init()
    self.timeSinceLast = 10
    self.camera = Factory:createCamera()
    self.camera:insert()
end

function Game:finalize()
    for k, v in ipairs(self.objects) do
        v:remove()
    end

    self.objects = {}

    Factory:finalize()
    self.camera:remove()
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
end

function Game.onStateUpdate:video(dt)
end

function Game.onStateExit:video()
end

function Game.onStateEnter:blinking()
end

function Game.onStateUpdate:blinking(dt)
end

function Game.onStateExit:blinking()
end

function Game.onStateEnter:playing()
end

function Game.onStateUpdate:playing(dt)
end

function Game.onStateExit:playing()
end

function Game:isRunning()
    return self.itIsRunning
end

function Game:start()
    self.itIsRunning = true
    Map:init()
    self:changeState("playing")
end

function Game:stop()
    self:changeState("none")

    self.itIsRunning = false
    Map:finalize()
end