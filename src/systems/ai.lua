-- ai paddle system
local aiSystem = dream.system({
	pool = { 'position', 'size', 'paddle', 'velocity', 'ai' },
	ballpool = { 'position', 'size', 'velocity', 'ball' },
})

function aiSystem:update(dt)
	for _, paddle in ipairs(self.pool) do
		local ballCenter = self.ballpool[1].position.y + self.ballpool[1].size.height / 2
		local paddleCenter = paddle.position.y + paddle.size.height / 2

		-- paddle vertical movement
		local speed = 200

		if ballCenter < paddleCenter then
			paddle.velocity.dy = -speed
		elseif ballCenter > paddleCenter then
			paddle.velocity.dy = speed
		end

		-- stop the paddle if it's close enough to the ball
		if math.abs(ballCenter - paddleCenter) < 10 then
			paddle.velocity.dy = 0
		end

		-- slows down the ai if the ball is moving away from it
		if self.ballpool[1].velocity.dx < 0 then
			paddle.velocity.dy = paddle.velocity.dy / 3
		end
	end
end

return aiSystem
