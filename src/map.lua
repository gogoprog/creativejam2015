require 'factory'

Map = Map or {
    obstacles = {},
    blocks = {}
}

gengine.stateMachine(Map)

function Map:init(lvl)
    self:loadFile("data/map" .. lvl .. ".lua")
end

function Map:finalize()
    for k, v in ipairs(self.obstacles) do
        v:remove()
        gengine.entity.destroy(v)
    end
end

local textures = {
    "start",
    "end",
    "cuve"
}

function Map:loadFile(filename)
    for i=1,6 do
        self.blocks[i] = {false, false, false, false, false, false}
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

            if v == 1 then
                self.startPositionIndices = vector2(x, y)
            elseif v == 2 then
                self.endPositionIndices = vector2(x, y)
                self:addObstacle(x, y, v, false)
            else
                self:addObstacle(x, y, v, true)
            end
        end
    end

    for i=0, 7 do
        self:addObstacle(i, 0, 3, false)
        self:addObstacle(i, 7, 3, false)
        self:addObstacle(0, i, 3, false)
        self:addObstacle(7, i, 3, false)
    end
end

function Map:update(dt)

end

function Map:addObstacle(x, y, v, blocking)
    local b
    b = Factory:createObstacle(x, y, textures[v])
    table.insert(self.obstacles, b)
    b:insert()

    if blocking then
        self.blocks[x][y] = blocking
    end
end

function Map:getTilePosition(i, j)
    return vector2(i * 96 - 96*3.5, j * 96 - 96*3.5)
end

function Map:isBlocking(i, j)
    if i < 1 or i > 6 or j < 1 or j > 6 then
        return true
    end
    return self.blocks[i][j]
end
