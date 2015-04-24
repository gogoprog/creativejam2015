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

function Game.onStateEnter:running()
    self.itIsRunning = true
    Map:init()
end

function Game.onStateUpdate:running(dt)

end

function Game.onStateExit:running()
    self.itIsRunning = false
    Map:finalize()
end

function Game:isRunning()
    return self.itIsRunning
end
