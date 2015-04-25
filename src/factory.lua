require 'component_poolable'
require 'component_box'
require 'component_player'
require 'component_auto_remove'

Factory = Factory or {
    objects = {},
    collisionParticles = {}
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

function Factory:createSprite(texture, w, h, l)
    e = gengine.entity.create()
 
    e:addComponent(
        ComponentSprite(),
        {
            layer = l,
            texture = gengine.graphics.texture.get(texture),
            extent = vector2(w, h)
        },
        "sprite"
        )

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

function Factory:createCollisionParticle()
    local e = self:pickFromPool(self.objects)

    if not e then
        e = gengine.entity.create()

        e:addComponent(
            ComponentParticleSystem(),
            {
                texture = gengine.graphics.texture.get("star_particle"),
                size = 50,
                emitterRate = 10,
                emitterLifeTime = 1.5,
                extentRange = {vector2(32,32), vector2(34,34)},
                lifeTimeRange = {0.5, 1},
                directionRange = {2*3.14, 3*3.14},
                speedRange = {10, 100},
                rotationRange = {0, 0},
                spinRange = {-10, 10},
                linearAccelerationRange = {vector2(0,0), vector2(0,0)},
                scales = {vector2(1, 1)},
                colors = {vector4(0.8,0.8,0,1), vector4(1,1,0,1), vector4(0,0,0,0)},
                layer = 1000
            },
            "particle"
            )

        e:addComponent(
            ComponentPoolable(),
            {
                pool = self.collisionParticles
            }
            )

        e:addComponent(
            ComponentAutoRemove(),
            {
               duration = 2
            }
            )
    end

    e.particle:reset()

    return e
end

function Factory:createPlayer()
    local e = gengine.entity.create()
 
    e:addComponent(
        ComponentSprite(),
        {
            layer = 100,
            texture = gengine.graphics.texture.get("taupe"),
            color = vector4(0.9, 0.9, 0.9, 0.8)
        },
        "sprite"
        )
 
    e:addComponent(
        ComponentPlayer(),
        {
        },
        "player"
        )

    return e
end

function Factory:createHole()
    local e = gengine.entity.create()

    e:addComponent(
        ComponentSprite(),
        {
            layer = 99,
            texture = gengine.graphics.texture.get("hole"),
            color = vector4(0.9, 0.9, 0.9, 0.8),
            extent = vector2(200, 200)
        },
        "sprite"
        )

    return e
end