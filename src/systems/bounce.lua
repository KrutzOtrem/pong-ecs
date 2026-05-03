-- bounces the ball off the top and bottom of the screen
local bounceSystem = dream.system({
	pool = { 'position', 'size', 'velocity', 'ball' },
})

function bounceSystem:update(dt)
	for _, e in ipairs(self.pool) do
		if e.position.y <= 0 then
			e.position.y = 0
			e.velocity.dy = -(e.velocity.dy * 1.2) -- increase speed by 20% on each bounce for more dynamic gameplay
            self:getWorld():emit('wallHit')
		elseif e.position.y + e.size.height >= VIRTUAL_HEIGHT then
			e.position.y = VIRTUAL_HEIGHT - e.size.height
			e.velocity.dy = -(e.velocity.dy * 1.2) -- increase speed by 20% on each bounce for more dynamic gameplay
            self:getWorld():emit('wallHit')
		end
	end
end

return bounceSystem
