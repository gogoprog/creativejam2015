require 'game'

Application = Application or {

}

gengine.stateMachine(Application)

function Application:init()
    self.menu = Factory:createSprite("menu", 850, 850, 10)
    self.intro = Factory:createSprite("intro", 850, 850, 10)
end

function Application:start()
    Application.guiFadeFunction = function(self) self:changeState('intro') end
    self:showPage('intro', 500)
end

function Application:update(dt)
    self:updateState(dt)
end

function Application.onStateEnter:intro()
    self.done = false
    self.timeLeft = 2.0
    self.intro:insert()
end

function Application.onStateUpdate:intro(dt)
    self.timeLeft = self.timeLeft - dt
    if not self.done and (self.timeLeft < 0 or gengine.input.keyboard:isJustDown(41) or gengine.input.mouse:isJustDown(1)) then
        Application.guiFadeFunction = function(self) self:changeState('inMenu') end
        self:showPage('menu', 500)
        self.done = true
    end
end

function Application.onStateExit:intro()
    self.intro:remove()
end

function Application.onStateEnter:inMenu()
    self.menu:insert()
end

function Application.onStateUpdate:inMenu(dt)
    if gengine.input.keyboard:isJustUp(41) then
        gengine.application.quit()
    end
end

function Application.onStateExit:inMenu()
    self.menu:remove()
end

function Application.onStateEnter:inGame()
    Game:init()
    Game:start()
end

function Application.onStateUpdate:inGame(dt)
    Game:update(dt)
end

function Application.onStateExit:inGame()
    Game:stop()
    Game:finalize()
end

function Application:guiFadeFunction()
end

function Application:showPage(name, duration)
    gengine.gui.executeScript("showPage('" .. name .. "'," .. duration .. ");")
end

function Application:play()
    Application.guiFadeFunction = function(self) self:changeState('inGame') end
    self:showPage('hud', 500)
end

function Application:goToMenu()
    Application.guiFadeFunction = function(self) self:changeState('menu') end
    self:showPage('menu', 500)
end

function Application:transition()
    Application.guiFadeFunction = function(self) Game:changeState('transitionning') end
    self:showPage('hud', 250)
end

function Application:toNextLevel()
    Application.guiFadeFunction = function(self) Game:nextLevel() end
    self:showPage('hud', 250)
end