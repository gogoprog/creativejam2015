require 'component_poolable'
require 'component_box'

Factory = Factory or {
    objects = {}
}

function Factory:pickFromPool(t)
    local n = #t
    if n > 0 then
        local e = t[n]
        table.remove(t, n)
        return e
    end

    return nil
end

function Factory:init()
    gengine.graphics.texture.createFromDirectory("data/")
end

function Factory:finalize()
    for k, v in ipairs(self.objects) do
        gengine.entity.destroy(v)
    end
    self.objects = {}
end

function Factory:createCamera()
    local e = gengine.entity.create()

    e:addComponent(
        ComponentCamera(),
        {
            extent = vector2(800, 800)
        },
        "camera"
        )

    return e
end

function Factory:createObject(x, y)
    local e = self:pickFromPool(self.objects)
    if not e then
        e = gengine.entity.create()

        e:addComponent(
            ComponentPoolable(),
            {
                pool = self.objects
            }
            )

         e:addComponent(
            ComponentSprite(),
            {
                layer = 1,
                texture = gengine.graphics.texture.get("logo")
            },
            "sprite"
            )
    end

    e.position:set(x, y)

    return e
end
function Factory:createObstacle(i, j, texture)
    local e = gengine.entity.create()

    e:addComponent(
        ComponentSprite(),
        {
            texture = gengine.graphics.texture.get(texture),
            layer = 0,
        },
        "sprite"
        )

    e:addComponent(
        ComponentBox(),
        {
        },
        "box"
        )

    e.box:setPosition(i , j)

    return e
end
