-- velocity component
dream.component('velocity', function(c, dx, dy)
	c.dx = dx or 0
	c.dy = dy or 0
end)
