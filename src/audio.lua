Audio = {}

function Audio:init()
    local defs = {
        dead = { "DEAD", "DEAD2" },
        collision = { "COLLISION" },
        start = { "START" }
    }

    self.sounds = {}

    for k, names in pairs(defs) do
        self.sounds[k] = {}
        for _, name in ipairs(names) do
            gengine.audio.sound.create("data/" .. name .. ".ogg")
            table.insert(self.sounds[k], gengine.audio.sound.get(name))
        end
    end
end

function Audio:playSound(name)
    local s = self.sounds[name]
    local index = (#s == 1) and 1 or math.random(1, #s)
    gengine.audio.playSound(s[index], 0.9)
end