-- checks collision between the ball and the paddle
local collisionSystem = dream.system({
	ballpool = { 'position', 'size', 'velocity', 'ball' },
	paddlepool = { 'position', 'size', 'velocity', 'paddle' },
})

function collisionSystem:update(dt)
	for _, ball in ipairs(self.ballpool) do
		for _, paddle in ipairs(self.paddlepool) do

			local ballCenter = ball.position.y + ball.size.height / 2
			local paddleCenter = paddle.position.y + paddle.size.height / 2
			local offset = (ballCenter - paddleCenter) / (paddle.size.height / 2) -- -1 to 1 based on where the ball hits the paddle

			if
				ball.position.x < paddle.position.x + paddle.size.width
				and ball.position.x + ball.size.width > paddle.position.x
				and ball.position.y < paddle.position.y + paddle.size.height
				and ball.position.y + ball.size.height > paddle.position.y
			then
				-- collision detected, reverse the ball's x velocity
				ball.velocity.dx = -ball.velocity.dx
				ball.velocity.dy = offset * 150 -- max deflection of 150
				ball.velocity.dy = ball.velocity.dy + (paddle.velocity.dy * 0.3) -- add some of the paddle's velocity to the ball for more dynamic gameplay

				if ball.position.x > paddle.position.x then
					ball.position.x = paddle.position.x + paddle.size.width
				else
					ball.position.x = paddle.position.x - ball.size.width
				end

				-- hit event
				self:getWorld():emit('paddleHit')

			end
		end
	end
end

return collisionSystem
