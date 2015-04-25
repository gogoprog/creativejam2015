require 'factory'

Map = Map or {
    obstacles = {},
    blocks = {}
}

gengine.stateMachine(Map)

function Map:init()
    self:loadFile("data/map1.lua")

    for i=1,6 do
        self.blocks[i] = {0, 0, 0, 0, 0, 0}
    end
end

function Map:finalize()

end

local textures = {
    "start",
    "end",
    "obstacle"
}

function Map:loadFile(filename)
    for i=1,6 do
        self.blocks[i] = {0, 0, 0, 0, 0, 0}
    end

    local map = dofile(filename)
    local w = map.width
    local h = map.height
    local data = map.layers[1].data
    local tilesets = map.tilesets

    for k, v in ipairs(data) do
        if v ~= 0 then
            local x = ((k-1) % w) + 1
            local y = (h - math.floor((k-1)/w))
            local b

            b = Factory:createObstacle(x, y, textures[v])
            table.insert(self.obstacles, b)
            print(x .. y)

            b:insert()

            if v == 1 then
                -- start
            elseif v == 2 then
                -- stop
            else
                self:addObstacle(x, y)
            end
        end
    end
end

function Map:update(dt)

end

function Map:addObstacle(x, y)
    self.blocks[x][y] = true
end
