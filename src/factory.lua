require 'component_poolable'
require 'component_box'
require 'component_player'
require 'component_auto_remove'
require 'component_shaker'

Factory = Factory or {
    objects = {},
    collisionParticles = {},
    fireworkParticles = {},
    bonusParticles = {},
    lifeParticules = {}
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

    local atlas
    self.animations = {}

    atlas = gengine.graphics.atlas.create(
        "dig",
        gengine.graphics.texture.get("dig"),
        1,
        7
        )

    self.animations.dig = gengine.graphics.animation.create(
        "dig",
        {
            atlas = atlas,
            frames = { 0, 1, 2, 3, 4, 5, 6 },
            framerate = 16,
            loop = true
        }
        )

    atlas = gengine.graphics.atlas.create(
        "idle",
        gengine.graphics.texture.get("idle"),
        1,
        7
        )

    self.animations.idle = gengine.graphics.animation.create(
        "idle",
        {
            atlas = atlas,
            frames = { 0, 1, 2, 3, 4, 5, 6 },
            framerate = 16,
            loop = true
        }
        )

    atlas = gengine.graphics.atlas.create(
        "collision",
        gengine.graphics.texture.get("collision"),
        1,
        7
        )

    self.animations.collision = gengine.graphics.animation.create(
        "collision",
        {
            atlas = atlas,
            frames = { 0, 1, 2, 3, 4, 5, 6 },
            framerate = 16,
            loop = false
        }
        )

    atlas = gengine.graphics.atlas.create(
        "dead",
        gengine.graphics.texture.get("dead"),
        1,
        10
        )

    self.animations.dead = gengine.graphics.animation.create(
        "dead",
        {
            atlas = atlas,
            frames = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 9, 9, 9, 9, 9, 9 },
            framerate = 5,
            loop = false
        }
        )

    atlas = gengine.graphics.atlas.create(
        "interrogation",
        gengine.graphics.texture.get("interrogation_mark"),
        1,
        8
        )

    self.animations.interrogation = gengine.graphics.animation.create(
        "interrogation",
        {
            atlas = atlas,
            frames = { 0, 1, 2, 3, 4, 5, 6, 7 },
            framerate = 16,
            loop = true
        }
        )

    atlas = gengine.graphics.atlas.create(
        "periscope",
        gengine.graphics.texture.get("periscope"),
        1,
        6
        )

    self.animations.periscope = gengine.graphics.animation.create(
        "periscope",
        {
            atlas = atlas,
            frames = { 0, 1, 2, 3, 4, 5, 4, 5, 4, 5, 4, 5, 4, 5, 4, 5, 4, 5 },
            framerate = 8,
            loop = false
        }
        )
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

    e:addComponent(
        ComponentShaker(),
        {
        },
        "shaker"
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

function Factory:createObstacle(i, j, texture, glow, anim)
    local e = gengine.entity.create()

    if not anim then
        e:addComponent(
            ComponentSprite(),
            {
                texture = gengine.graphics.texture.get(texture),
                layer = 1,
                extent = vector2(96,96)
            },
            "sprite"
            )
    else
        e:addComponent(
            ComponentAnimatedSprite(),
            {
                animation = self.animations[texture],
                layer = 1,
                --extent = vector2(96,96)
            },
            "sprite"
            )
    end

    e:addComponent(
        ComponentBox(),
        {
        },
        "box"
        )

    if glow then
        e:addComponent(
            ComponentParticleSystem(),
            {
                texture = gengine.graphics.texture.get("star_particle"),
                size = 1,
                emitterRate = 1000,
                emitterLifeTime = 10240,
                extentRange = {vector2(160,160), vector2(160,160)},
                lifeTimeRange = {1, 1},
                directionRange = {2*3.14, 3*3.14},
                speedRange = {0, 0},
                rotationRange = {0, 0},
                spinRange = {-10, 10},
                linearAccelerationRange = {vector2(0,0), vector2(0,0)},
                scales = {vector2(1, 1), vector2(0.5, 0.5), vector2(1, 1)},
                colors = {vector4(1,1,0,1)},
                layer = 0
            },
            "particle"
            )
    end

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
                colors = {vector4(1,0,0,1), vector4(0.8,0,0,0.8), vector4(0,0,0,0)},
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

function Factory:createFireworkParticle()
    local e = self:pickFromPool(self.fireworkParticles)

    if not e then
        e = gengine.entity.create()

        e:addComponent(
            ComponentParticleSystem(),
            {
                texture = gengine.graphics.texture.get("particle"),
                size = 100,
                emitterRate = 1000,
                emitterLifeTime = 1,
                extentRange = {vector2(32,32), vector2(34,34)},
                lifeTimeRange = {0, 1},
                directionRange = {0, 2*3.14},
                speedRange = {500, 500},
                rotationRange = {0, 0},
                spinRange = {0, 1},
                linearAccelerationRange = {vector2(0,-400), vector2(0,-500)},
                scales = {vector2(0.2, 0.2)},
                colors = {vector4(0.8,0,0.9,1), vector4(0.3,0.3,0.5,1), vector4(0,0,0,0)},
                layer = 10000
            },
            "p1"
            )

         e:addComponent(
            ComponentParticleSystem(),
            {
                texture = gengine.graphics.texture.get("particle"),
                size = 100,
                emitterRate = 1000,
                emitterLifeTime = 1,
                extentRange = {vector2(32,32), vector2(34,34)},
                lifeTimeRange = {0, 1},
                directionRange = {0, 2*3.14},
                speedRange = {500, 500},
                rotationRange = {0, 0},
                spinRange = {0, 1},
                linearAccelerationRange = {vector2(0,-400), vector2(0,-500)},
                scales = {vector2(0.2, 0.2)},
                colors = {vector4(0.7,0.4,0.7,1), vector4(0.5,0.6,0.5,1), vector4(0,0,0,0)},
                layer = 1000
            },
            "p2"
            )

        e:addComponent(
            ComponentParticleSystem(),
            {
                texture = gengine.graphics.texture.get("particle"),
                size = 100,
                emitterRate = 1000,
                emitterLifeTime = 1,
                extentRange = {vector2(32,32), vector2(34,34)},
                lifeTimeRange = {0, 1},
                directionRange = {0, 3.14},
                speedRange = {500, 500},
                rotationRange = {0, 0},
                spinRange = {0, 1},
                linearAccelerationRange = {vector2(0,-400), vector2(0,-500)},
                scales = {vector2(0.2, 0.2)},
                colors = {vector4(0.8,0.3,0.4,1), vector4(0.9,0.6,0.3,1), vector4(0,0,0,0)},
                layer = 10000
            },
            "p3"
            )


         e:addComponent(
            ComponentParticleSystem(),
            {
                texture = gengine.graphics.texture.get("particle"),
                size = 100,
                emitterRate = 1000,
                emitterLifeTime = 1,
                extentRange = {vector2(32,32), vector2(34,34)},
                lifeTimeRange = {0, 1},
                directionRange = {0, 3.14},
                speedRange = {500, 500},
                rotationRange = {0, 0},
                spinRange = {0, 1},
                linearAccelerationRange = {vector2(0,-400), vector2(0,-500)},
                scales = {vector2(0.2, 0.2)},
                colors = {vector4(0.8,0.1,0.1,1), vector4(1,1,0,1), vector4(0,0,0,0)},
                layer = 10000
            },
            "p4"
            )

         e:addComponent(
            ComponentPoolable(),
            {
                pool = self.fireworkParticles
            }
            )

        e:addComponent(
            ComponentAutoRemove(),
            {
               duration = 2
            }
            )
    end

    e.p1:reset()
    e.p2:reset()
    e.p3:reset()
    e.p4:reset()

    return e
end

function Factory:createBonusParticles()
    local e = self:pickFromPool(self.bonusParticles)

    if not e then
        e = gengine.entity.create()

        e:addComponent(
            ComponentParticleSystem(),
            {
                texture = gengine.graphics.texture.get("glasses"),
                size = 1,
                emitterRate = 100,
                emitterLifeTime = 0.1,
                extentRange = {vector2(32,32), vector2(34,34)},
                lifeTimeRange = {1, 1},
                directionRange = {0, 0},
                speedRange = {0, 10},
                rotationRange = {0, 0},
                spinRange = {0, 0},
                linearAccelerationRange = {vector2(0,0), vector2(0,0)},
                scales = {vector2(5, 5),vector2(15,15)},
                colors = {vector4(0,0.8,0.8,1), vector4(0,0.8,0.8,0)},
                layer = 10000
            },
            "particle"
            )

        e:addComponent(
            ComponentPoolable(),
            {
                pool = self.bonusParticles
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

function Factory:createLifeParticles()
    local e = self:pickFromPool(self.lifeParticules)

    if not e then
        e = gengine.entity.create()

        e:addComponent(
            ComponentParticleSystem(),
            {
                texture = gengine.graphics.texture.get("life"),
                size = 1,
                emitterRate = 100,
                emitterLifeTime = 0.1,
                extentRange = {vector2(32,32), vector2(34,34)},
                lifeTimeRange = {1, 1},
                directionRange = {0, 0},
                speedRange = {0, 10},
                rotationRange = {0, 0},
                spinRange = {0, 0},
                linearAccelerationRange = {vector2(0,0), vector2(0,0)},
                scales = {vector2(5, 5),vector2(15,15)},
                colors = {vector4(1,0,0,1), vector4(1,0,0,1)},
                layer = 10000
            },
            "particle"
            )

        e:addComponent(
            ComponentPoolable(),
            {
                pool = self.lifeParticules
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
        ComponentAnimatedSprite(),
        {
            animation = self.animations.idle,
            layer = 100
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