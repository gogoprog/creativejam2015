
require 'application'

function init()
    gengine.application.setName("CreativeJam2015")
    gengine.application.setExtent(800, 800)
    gengine.application.setFullscreen(false)
end


function start()
    gengine.graphics.setClearColor(0.5, 0.5, 0.5, 1)

    gengine.gui.loadFile("gui/main.html")

    Application:changeState("inMenu")
end

function update(dt)
    Application:update(dt)
end

function stop()
end
