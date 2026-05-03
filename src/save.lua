local twine = require('lib/binser')

local entwine = {}

function entwine.capture(state)
	local data = {}

	if state.world then
		data.world = state.world:serialize()
	end

	if state.save then
		data.state = state:save()
	end

	return data
end

function entwine.apply(state, data)
	if not data then
		return false
	end

	if data.world and state.world then
		state.world:deserialize(data.world, true)
	end

	if state.load then
		state:load(data.state or {})
	end

	return true
end

function entwine.write(state, filename)
	twine.writeFile(filename, entwine.capture(state))
end

function entwine.read(state, filename)
	if not love.filesystem.getInfo(filename) then
		return false
	end

	local results = twine.readFile(filename)
	return entwine.apply(state, results[1])
end

return entwine
