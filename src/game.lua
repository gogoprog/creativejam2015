require 'factory'
require 'map'

Game = Game or {
    mapCount = 12,
    numberOfGlasses = 1,
    numberOfLife = 3
}

gengine.stateMachine(Game)

function Game:init(dt)
    gengine.audio.playMusic("data/niquer-au-plutaupe.mp3", 1.0, true)

    self.camera = Factory:createCamera()
    self.camera:insert()

    self.ground = Factory:createSprite("grass", 850, 850, 10)
    self.blackSight = Factory:createSprite("black_sight", 850, 850, 1000)
    self.goal = Factory:createSprite("goal", 850, 850, 999)
    self.underground = Factory:createSprite("underground", 850, 850, -10)
    self.player = Factory:createPlayer()
    self.hole = Factory:createHole()

    self.numberOfGlasses = 1
    self.numberOfLife = 3

    gengine.gui.executeScript("updateGlasses("..self.numberOfGlasses..")")
    gengine.gui.executeScript("updateLife("..self.numberOfLife..")") 
end

function Game:finalize()
    gengine.entity.destroy(self.camera)
    gengine.entity.destroy(self.ground)
    gengine.entity.destroy(self.blackSight)
    gengine.entity.destroy(self.goal)
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

function Game.onStateEnter:wait()
    self.timeLeft = 1.0
end

function Game.onStateUpdate:wait(dt)
    self.timeLeft = self.timeLeft - dt

    if self.timeLeft < 0 then
        self:changeState("blinking")
    end
end

function Game.onStateExit:wait()
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
        self:changeState("none")
        Application:goToMenu()
    end
end

function Game.onStateExit:playing()
    self.itIsPlayable = false
end

function Game.onStateEnter:winning()
    self.time = 2

    local e = Factory:createFireworkParticle()
    e:insert()

end

function Game.onStateUpdate:winning(dt)
    self.time = self.time - dt

    self.player.rotation = self.player.rotation + dt * 10

    if self.time < 0 then
        self:nextLevel()
        self:changeState("none")
        Application:transition()
    end
end

function Game.onStateExit:winning()
end

function Game.onStateEnter:transitionning()
    self.blackSight:insert()
    self.goal:insert()
    self.goal.sprite.extent = vector2(850,850) * ( 1 + (self.currentLevel) * 0.2)
    self.time = 2
    self.done = false
end

function Game.onStateUpdate:transitionning(dt)
    self.time = self.time - dt

    if self.time < 0 and not self.done then
        Application:toNextLevel()
        self.done = true
    end
end

function Game.onStateExit:transitionning()
    self.goal:remove()
    self.blackSight:remove()
end

function Game.onStateEnter:losing()
    self.time = 2
    Audio:playSound("dead")
end

function Game.onStateUpdate:losing(dt)
    self.time = self.time - dt

    self.player.rotation = self.player.rotation + dt * 10

    if self.time < 0 then
        self:changeState("none")
        Application:goToMenu()
    end
end

function Game.onStateExit:losing()
end

function Game:isRunning()
    return self.itIsRunning
end

function Game:start(lvl)
    Audio:playSound("start")

    self.itIsRunning = true

    self.currentLevel = lvl or 0
    gengine.gui.executeScript("updateLevel("..self.currentLevel..")")

    self:loadLevel()

    self.underground:insert()
    self.ground:insert()
    self.player:insert()
    self.hole:insert()

    self:changeState("wait")
end

function Game:stop()
    self:changeState("none")

    self.itIsRunning = false
    Map:finalize()

    self.camera:remove()
    self.ground:remove()
    self.underground:remove()
    self.player:remove()
    self.hole:remove()
end

function Game:nextLevel()
    Map:finalize()
    self.currentLevel = self.currentLevel + 1
    if self.currentLevel >= self.mapCount then
        self.currentLevel = 0
    end
    self:loadLevel()
    gengine.gui.executeScript("updateLevel("..self.currentLevel..")")
end

function Game:loadLevel()
    Map:init(self.currentLevel)

    local indices = Map.startPositionIndices
    self.player.position:set(Map:getTilePosition(indices.x, indices.y))
    self.player.player.indices = indices
    self.hole.position = self.player.position

    self:changeState("wait")
end

function Game:addGlasses( value )
    self.numberOfGlasses = self.numberOfGlasses + value
    gengine.gui.executeScript("updateGlasses("..self.numberOfGlasses..")")
end

function Game:getNumberOfGlasses()
    return self.numberOfGlasses
end 

function Game:addLife( value )
    self.numberOfLife = self.numberOfLife + value
    if self.numberOfLife <= 0 then
        self:changeState("losing")
    end
    gengine.gui.executeScript("updateLife("..self.numberOfLife..")")
end

function Game:getLife()
    return self.numberOfLife
end

function Game:win()
    Audio:playSound("win", 2, 0.3)
    self:changeState("none")
    Application:transition()
end
