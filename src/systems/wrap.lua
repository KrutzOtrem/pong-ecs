-- paddle wrap system
local wrapSystem = dream.system({
	pool = { 'position', 'size', 'paddle' },
})

function wrapSystem:update(dt)
	for _, e in ipairs(self.pool) do
		if e.position.y <= 0 then
			e.position.y = 0
        elseif e.position.y + e.size.height >= VIRTUAL_HEIGHT then
            e.position.y = VIRTUAL_HEIGHT - e.size.height
		end
	end
end

return wrapSystem
