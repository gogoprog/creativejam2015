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
    "obstacle"
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
            local b

            if v ~= 1 then
                b = Factory:createObstacle(x, y, textures[v])
                table.insert(self.obstacles, b)

                b:insert()
            end

            if v == 1 then
                self.startPositionIndices = vector2(x, y)
            elseif v == 2 then
                self.endPositionIndices = vector2(x, y)
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

function Map:getTilePosition(i, j)
    return vector2(i * 96 - 96*3.5, j * 96 - 96*3.5)
end

function Map:isBlocking(i, j)
    if i < 1 or i > 6 or j < 1 or j > 6 then
        return true
    end
    return self.blocks[i][j]
end
