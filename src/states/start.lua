return {
      enter = function(self) end,

      update = function(self, dt)
          if input:wasPressed('enter') or input:wasPressed('return') then
              return 'game'
          end
      end,

      draw = function(self)
          love.graphics.setFont(Assets.fonts.large)
          love.graphics.printf('PONG', 0, VIRTUAL_HEIGHT / 2 - 30, VIRTUAL_WIDTH, 'center')  
          love.graphics.setFont(Assets.fonts.small)
          love.graphics.printf('Press Enter to start', 0, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH, 'center')
      end,
  }