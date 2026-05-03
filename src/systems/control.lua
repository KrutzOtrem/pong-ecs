-- control system
local controlSystem = dream.system({
	pool = { 'velocity', 'controllable' },
})

-- applies player input to entities with a controllable component
function controlSystem:update(dt)
	local input = self:getWorld():getResource('input')
	for _, e in ipairs(self.pool) do
		if input:isDown('w') then
			e.velocity.dy = -200
		elseif input:isDown('s') then
			e.velocity.dy = 200
		else
			e.velocity.dy = 0
		end
	end
end

return controlSystem
