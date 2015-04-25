require 'factory'
require 'map'

Game = Game or {
    objects = {},
    mapCount = 4,
    numberOfGlasses = 0,
    numberOfLife = 3
}

gengine.stateMachine(Game)

function Game:init(dt)
    Factory:init()
    self.camera = Factory:createCamera()
    self.camera:insert()

    self.ground = Factory:createSprite("grass", 850, 850, 10)
    self.underground = Factory:createSprite("underground", 850, 850, -10)
    self.player = Factory:createPlayer()
    self.hole = Factory:createHole()
end

function Game:finalize()
    for k, v in ipairs(self.objects) do
        gengine.entity.destroy(v)
    end

    self.objects = {}

    Factory:finalize()

    gengine.entity.destroy(self.camera)
    gengine.entity.destroy(self.ground)
    gengine.entity.destroy(self.underground)
    gengine.entity.destroy(self.player)
    gengine.entity.destroy(self.hole)
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
end

function Game.onStateUpdate:blinking(dt)
    self.time = self.time + dt

    local value = math.cos(self.time * 2) / 2 + 0.5

    self.ground.sprite.color = vector4(1,1,1, value)
    self.hole.sprite.color = vector4(1,1,1, value)

    if self.time > 1 and value > 0.99 then
        self:changeState("playing")
    end
end

function Game.onStateExit:blinking()
end

function Game.onStateEnter:playing()
    self.itIsPlayable = true
end

function Game.onStateUpdate:playing(dt)
    self.hole.position = self.player.position

    if gengine.input.keyboard:isJustUp(41) then
        Application:goToMenu()
    end
end

function Game.onStateExit:playing()
    self.itIsPlayable = false
end


function Game.onStateEnter:winning()
    self.time = 2
end

function Game.onStateUpdate:winning(dt)
    self.time = self.time - dt

    self.player.rotation = self.player.rotation + dt * 10

    if self.time < 0 then
        self:nextLevel()
    end
end

function Game.onStateExit:winning()
end

function Game:isRunning()
    return self.itIsRunning
end

function Game:start(lvl)
    self.itIsRunning = true

    self.currentLevel = lvl or 1

    self:loadLevel()

    self.hole.position = self.player.position

    self.underground:insert()
    self.ground:insert()
    self.player:insert()
    self.hole:insert()


    self:changeState("video")
end

function Game:stop()
    self:changeState("none")

    self.itIsRunning = false
    Map:finalize()

    for k, v in ipairs(self.objects) do
        v:remove()
    end

    self.camera:remove()
    self.ground:remove()
    self.underground:remove()
    self.player:remove()
    self.hole:remove()
end

function Game:nextLevel()
    Map:finalize()
    self.currentLevel = self.currentLevel + 1
    if self.currentLevel > self.mapCount then
        self.currentLevel = 1
    end
    self:loadLevel()
end

function Game:loadLevel()
    Map:init(self.currentLevel)

    local indices = Map.startPositionIndices
    self.player.position:set(Map:getTilePosition(indices.x, indices.y))
    self.player.player.indices = indices

    self:changeState("video")
end

function Game:addGlasses( value )
    self.numberOfGlasses = self.numberOfGlasses + value
end

function Game:getNumberOfGlasses()
    return self.numberOfGlasses
end 

function Game:addLife( value )
    self.numberOfLife = self.numberOfLife + value
end

function Game:getLife()
    return self.numberOfLife
end