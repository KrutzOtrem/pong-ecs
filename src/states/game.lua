return {
	-- !! ENTER
	enter = function(self)
		self.world = dream.world()
		self.world:setResource('input', input)

		-- Add project systems here.
		self.world:addSystems(
			Systems.control,
			Systems.ai,
			Systems.move,
			Systems.wrap,
			Systems.bounce,
			Systems.collision,
			Systems.render,
			Systems.score,
			Systems.sound
		)

		-- assambles the player entity
		self.world:newEntity():assemble(Assemblages.paddle, 10, VIRTUAL_HEIGHT / 2 - 20, 5, 30, 'controllable')

		-- assambles the ai entity
		self.world:newEntity():assemble(Assemblages.paddle, VIRTUAL_WIDTH - 15, VIRTUAL_HEIGHT / 2 - 20, 5, 30, 'ai')

		-- assambles the ball entity
		self.ball =
			self.world:newEntity():assemble(Assemblages.ball, VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 0, 0)

		-- score system
		self.score = { player = 0, ai = 0 }
		self.world:setResource('score', self.score)

		-- serve phase
		self.phase = 'serve'
	end,

	-- !! UPDATE
	update = function(self, dt)
		if self.phase == 'serve' then
			self.ball.position.x = VIRTUAL_WIDTH / 2 - self.ball.size.width / 2
			self.ball.position.y = VIRTUAL_HEIGHT / 2 - self.ball.size.height / 2

			self.world:emit('update', dt)

			-- on space, give ball velocity and switch to play
			if input:wasPressed('space') then
				if self.score.lastScorer == 'player' then
					self.ball.velocity.dx = 90
				else
					self.ball.velocity.dx = -90
				end
				self.ball.velocity.dy = math.random(-80, 80)
				self.phase = 'play'
			end
		elseif self.phase == 'play' then
			self.world:emit('update', dt)
			if self.score.goal then
				self.score.goal = false

				-- check for victory condition
				if self.score.player >= 3 then
					self.phase = 'victory'
					self.winner = 'Player'
				elseif self.score.ai >= 3 then
					self.phase = 'victory'
					self.winner = 'AI'
				else
					self.phase = 'serve' -- reset to serve for next round
				end
			end
		elseif self.phase == 'victory' then
			-- wait for enter to return to start screen
			if input:wasPressed('enter') or input:wasPressed('return') then
				return 'game'
			end
		end
	end,

	-- !! DRAW
	draw = function(self)
		if self.phase ~= 'victory' then
			self.world:emit('draw')

			-- middle stripes
			love.graphics.setColor(1, 1, 1, 1)
			for y = 2, VIRTUAL_HEIGHT, 8 do
				love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 1, y, 2, 4)
			end
		end
		-- draw the score
		love.graphics.setFont(Assets.fonts.large)
		love.graphics.print(self.score.player, VIRTUAL_WIDTH / 2 - 50, 10)
		love.graphics.print(self.score.ai, VIRTUAL_WIDTH / 2 + 30, 10)

		if self.phase == 'victory' then
			love.graphics.setFont(Assets.fonts.large)
			love.graphics.printf(self.winner .. ' wins!', 0, VIRTUAL_HEIGHT / 2 - 30, VIRTUAL_WIDTH, 'center')
			love.graphics.setFont(Assets.fonts.small)
			love.graphics.printf('Press Enter to restart', 0, VIRTUAL_HEIGHT / 2 + 10, VIRTUAL_WIDTH, 'center')
		end
	end,

	-- Non-ECS state can be saved here.
	save = function(self)
		return {}
	end,

	-- Non-ECS state can be restored here.
	load = function(self, data) end,
}
