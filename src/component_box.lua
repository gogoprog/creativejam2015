ComponentBox = {}

function ComponentBox:init()
end

function ComponentBox:insert()
end

function ComponentBox:update(dt)

end

function ComponentBox:remove()

end

function ComponentBox:setPosition(i, j)
    self.entity.position:set(Map:getTilePosition(i,j))
end
