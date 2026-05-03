local input = {}

function input:init()
    self.pressed = {}
    self.down = {}
end

function input:update()
    self.pressed = {}
end

function input:keyPressed(key)
    self.pressed[key] = true
    self.down[key] = true
end

function input:keyReleased(key)
    self.down[key] = nil
end

function input:wasPressed(key)
    return self.pressed[key] == true
end

function input:isDown(key)
    return self.down[key] == true
end

return input
