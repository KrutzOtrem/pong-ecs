-- movement system
local moveSystem = dream.system({
	pool = { 'position', 'velocity' },
})


-- updates the position of entities based on their velocity
function moveSystem:update(dt)
	for _, e in ipairs(self.pool) do
		e.position.x = e.position.x + e.velocity.dx * dt
		e.position.y = e.position.y + e.velocity.dy * dt
	end
end

return moveSystem