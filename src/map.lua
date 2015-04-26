require 'factory'

Map = Map or {
    obstacles = {},
    blocks = {},
    glasses = {},
    lifes = {},
    teleports = {}
}

gengine.stateMachine(Map)

function Map:init(lvl)
    self:loadFile("data/map" .. lvl .. ".lua", lvl)
end

function Map:finalize()
    for k, v in ipairs(self.obstacles) do
        if v:isInserted() then
            v:remove()
        end
        gengine.entity.destroy(v)
    end

    self.obstacles = {}
end

local textures = {
    "start",
    "finish",
    "cuve",
    "glasses",
    "life",
    "random",
    "rock1",
    "rock2",
    "rock3",
    "rock4"
}

function Map:loadFile(filename, id)

    local map = dofile(filename)
    local w = map.width
    local h = map.height
    self.width = w
    self.height = h
    local data = map.layers[1].data
    local tilesets = map.tilesets

    for i=1,self.width do
        self.blocks[i] = {false, false, false, false, false, false, false, false}
        self.glasses[i] = {false, false, false, false, false, false, false, false}
        self.lifes[i] = {false, false, false, false, false, false, false, false}
        self.teleports[i] = {false, false, false, false, false, false, false, false}
    end

    for k, v in ipairs(data) do
        if v ~= 0 then
            local x = ((k-1) % w) + 1
            local y = (h - math.floor((k-1)/w))

            if v == 1 then
                self.startPositionIndices = vector2(x, y)
            elseif v == 2 then
                self.endPositionIndices = vector2(x, y)
                self:addObstacle(x, y, v, false, true)
            elseif v == 3 then
                self:addObstacle(x, y, v, true)
            elseif v == 4 then
                self.glasses[x][y] = self:addObstacle(x, y, v, false)
            elseif v == 5 then
                self.lifes[x][y] = self:addObstacle(x, y, v, false)
            elseif v == 6 then
                math.randomseed(id)
                local r = math.random(1, 3)

                if r == 1 then
                    self.glasses[x][y] = self:addObstacle(x, y, v, false)
                elseif r == 2 then
                    self.lifes[x][y] = self:addObstacle(x, y, v, false)
                else
                    self.teleports[x][y] = self:addObstacle(x, y, v, false)
                end
            end
        end
    end

    for i=0, self.width + 1 do
        self:addObstacle(i, 0, 3, false)
        self:addObstacle(i, self.width + 1, 3, false)
        self:addObstacle(0, i, 3, false)
        self:addObstacle(self.width + 1, i, 3, false)
    end
end

function Map:update(dt)

end

function Map:addObstacle(x, y, v, blocking, glow)
    local b
    b = Factory:createObstacle(x, y, textures[v], glow)
    table.insert(self.obstacles, b)
    b:insert()

    if blocking then
        self.blocks[x][y] = blocking
    end

    return b
end

function Map:getTilePosition(i, j)
    return vector2(i * 96 - 96*4.5, j * 96 - 96*4.5)
end

function Map:isBlocking(i, j)
    if i < 1 or i > self.width or j < 1 or j > self.height then
        return true
    end
    return self.blocks[i][j]
end

function Map:isLife(i, j)
    return self.lifes[i][j]
end

function Map:isTeleport(i, j)
    return self.teleports[i][j]
end

function Map:isGlasses(i, j)
    return self.glasses[i][j]
end

function Map:removeGlasses(i, j)
    local e = self.glasses[i][j]
    e:remove()
    self.glasses[i][j] = false
end

function Map:removeLife(i, j)
    local e = self.lifes[i][j]
    e:remove()
    self.lifes[i][j] = false
end

function Map:removeTeleport(i, j)
    local e = self.teleports[i][j]
    e:remove()
    self.teleports[i][j] = false
end
