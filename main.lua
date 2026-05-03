dream = require('lib/Concord')
push = require('lib/push')

Config = require('src/config')
Assets = require('src/assets')
entwine = require('src/save')
input = require('src/input')

VIRTUAL_WIDTH = Config.virtualWidth
VIRTUAL_HEIGHT = Config.virtualHeight
WINDOW_WIDTH = Config.windowWidth
WINDOW_HEIGHT = Config.windowHeight

dream.utils.loadNamespace('src/components')
Systems = {}
dream.utils.loadNamespace('src/systems', Systems)
Assemblages = {}
dream.utils.loadNamespace('src/assemblages', Assemblages)

local stateMachine = require('lib/batteries/state_machine')

States = {}
dream.utils.loadNamespace('src/states', States)

local weave

-- !! LOAD
function love.load()
	-- setup the graphics
	love.graphics.setDefaultFilter('nearest', 'nearest')

	-- setup the window
	love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
		vsync = Config.vsync,
		fullscreen = Config.fullscreen,
		resizable = Config.resizable,
	})

	-- randomness seed
	math.randomseed(os.time())

	-- title
	love.window.setTitle(Config.title)

	-- initializes shared fonts/images/audio
	Assets.load()

	-- setup the screen
	push.setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, { upscale = 'normal' })

	-- initializes the input system
	input:init()

	-- initializes the state machine
	weave = stateMachine(States, 'start')
end

-- !! UPDATE
function love.update(dt)
	weave:update(dt)
	input:update()
end

-- !! DRAW
function love.draw()
	push.start()

	weave:draw()

	push.finish()
end

-- !! CUSTOM FUNCTIONS

-- keypressed
function love.keypressed(key)
	-- updates the input system
	input:keyPressed(key)

	-- quits the game
	if key == 'escape' then
		love.event.quit()
	end

	if key == 't' then
		entwine.write(weave:current_state(), Config.saveFile)
	elseif key == 'y' then
		entwine.read(weave:current_state(), Config.saveFile)
	end

	local state = weave:current_state()
	if state.keypressed then
		state:keypressed(key)
	end
end

-- keyreleased
function love.keyreleased(key)
	input:keyReleased(key)

	local state = weave:current_state()
	if state.keyreleased then
		state:keyreleased(key)
	end
end

-- resizes the game window
function love.resize(w, h)
	push.resize(w, h)
end
