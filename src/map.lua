require 'factory'

Map = Map or {
    obstacles = {}
}

gengine.stateMachine(Map)

function Map:init()
    self:loadFile("data/map1.lua")
end

function Map:finalize()

end

local textures = {
    "obstacle"
}

function Map:loadFile(filename)
    local map = dofile(filename)
    local w = map.width
    local h = map.height
    local data = map.layers[1].data
    local tilesets = map.tilesets

    for k, v in ipairs(data) do
        if v ~= 0 then
            local x = k % w
            local y = h - math.floor(k/w)
            local b

            b = Factory:createObstacle(x, y, textures[v])
            table.insert(self.obstacles, b)

            b:insert()
        end
    end
end

function Map:update(dt)

end
