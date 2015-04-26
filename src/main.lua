
require 'application'
require 'audio'

function init()
    gengine.application.setName("CreativeJam2015")
    gengine.application.setExtent(800, 800)
    gengine.application.setFullscreen(false)

    gengine.application.setUpdateFactor(1.0)
end

function start()
    Audio:init()
    Factory:init()

    gengine.graphics.setClearColor(0.5, 0.5, 0.5, 1)

    gengine.gui.loadFile("gui/main.html")

    Application:changeState("inMenu")
end

function update(dt)
    Application:update(dt)
end

function stop()
    Factory:finalize()
end
