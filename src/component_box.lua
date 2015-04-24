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
    self.entity.position:set(i * 96 - 96*3, j * 96 - 96*3)
end
