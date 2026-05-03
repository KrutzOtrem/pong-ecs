-- sound system
local soundSystem = dream.system({})

function soundSystem:paddleHit()
    Assets.sounds.paddleHit:play()
end

function soundSystem:wallHit()
    Assets.sounds.wallHit:play()
end

function soundSystem:scored()
    Assets.sounds.scored:play()
end

return soundSystem