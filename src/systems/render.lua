-- render system
local renderSystem = dream.system({
	pool = { 'position', 'size', 'renderable' },
})

-- renders entities with a position, size, and renderable component
function renderSystem:draw()
	for _, e in ipairs(self.pool) do
		love.graphics.setColor(e.renderable.r, e.renderable.g, e.renderable.b)
		love.graphics.rectangle('fill', e.position.x, e.position.y, e.size.width, e.size.height)
	end
end

return renderSystem
