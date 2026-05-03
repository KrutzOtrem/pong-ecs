local Assets = {
	fonts = {},
	sounds = {},
}

function Assets.load()
	Assets.fonts.small = love.graphics.newFont('fonts/font.ttf', 8)
	Assets.fonts.medium = love.graphics.newFont('fonts/font.ttf', 16)
	Assets.fonts.large = love.graphics.newFont('fonts/font.ttf', 32)
	Assets.fonts.huge = love.graphics.newFont('fonts/font.ttf', 64)

	Assets.sounds.paddleHit = love.audio.newSource('sound/paddle.wav', 'static')
	Assets.sounds.wallHit = love.audio.newSource('sound/bounce.wav', 'static')
	Assets.sounds.scored = love.audio.newSource('sound/score.wav', 'static')

	love.graphics.setFont(Assets.fonts.small)
end

return Assets
