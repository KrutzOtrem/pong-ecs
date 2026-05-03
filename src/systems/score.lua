-- score system
local scoreSystem = dream.system({
	pool = { 'position', 'size', 'velocity', 'ball' },
})

function scoreSystem:update(dt)
	for _, ball in ipairs(self.pool) do
		if ball.position.x + ball.size.width < 0 then
			local score = self:getWorld():getResource('score')
			score.ai = score.ai + 1
			ball.position.x = VIRTUAL_WIDTH / 2 - ball.size.width / 2 -- temp solution to reset the ball
			ball.velocity.dx = 0
			ball.velocity.dy = 0
			score.goal = true
			score.lastScorer = 'ai'
			self:getWorld():emit('scored')
		end
		if ball.position.x > VIRTUAL_WIDTH + ball.size.width then
			local score = self:getWorld():getResource('score')
			score.player = score.player + 1
			ball.position.x = VIRTUAL_WIDTH / 2 - ball.size.width / 2 -- temp solution to reset the ball
			ball.velocity.dx = 0
			ball.velocity.dy = 0
			score.goal = true
			score.lastScorer = 'player'
			self:getWorld():emit('scored')
		end
	end
end

return scoreSystem
