
require 'application'
require 'audio'

function init()
    gengine.application.setName("CreativeJam2015")
    gengine.application.setExtent(768, 768)
    gengine.application.setFullscreen(false)

    gengine.application.setUpdateFactor(1.0)
end

function start()
    Audio:init()
    Factory:init()

    gengine.graphics.setClearColor(0.0, 0.0, 0.0, 1)

    Application:init()

    gengine.gui.onPageLoaded = function()
        Application:start()
    end

    gengine.gui.loadFile("gui/main.html")
end

function update(dt)
    Application:update(dt)
end

function stop()
    Factory:finalize()
end
