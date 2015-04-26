Audio = {
    itIsSoundAllowed = true,
    itIsMusicAllowed = true
}

function Audio:init()
    local defs = {
        dead = { "DEAD", "DEAD2" },
        win = { "WIN", "WIN2" },
        collision = { "COLLISION" },
        start = { "START" },
        bonus = { "BONUS", "BONUS2", "BONUS3", "BONUS4", "BONUS5" },
        walking = { "WALKING", "WALKING2" }
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

function Audio:playSound(name, index, volume)

    if self.itIsSoundAllowed then
        local s = self.sounds[name]
        index = index or ((#s == 1) and 1 or math.random(1, #s))
        gengine.audio.playSound(s[index], volume or 0.6)
    end
end


function Audio:playMusic()

    if   self.itIsMusicAllowed then
        if not self.music then
            gengine.audio.playMusic("data/niquer-au-plutaupe.mp3", 1.0, true)
            self.music = true
        end
    end
end

function Audio:setItIsSoundAllowed()
    self.itIsSoundAllowed = not self.itIsSoundAllowed
end

function Audio:setItIsMusicAllowed()
    self.itIsMusicAllowed = not self.itIsMusicAllowed
end