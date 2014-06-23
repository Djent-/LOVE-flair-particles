--main.lua
square = {}
particles = {}

function square:new(x,y)
	local self = {}
	self.x = x
	self.y = y
	self.w = 40
	self.h = 40
	self.angle = 0
	self.phase = 0
	self.canvas = love.graphics.newCanvas(40,40)
	love.graphics.setCanvas(self.canvas)
	love.graphics.rectangle("line", 0, 0, 40, 40)
	love.graphics.setCanvas()
	return self
end

function love.update(dt)
	if #particles == 0 then return end
	for x = 1, #squares do
		particles[x].angle = particles[x].angle + math.pi * dt
		particles[x].phase = particles[x].phase + math.pi * dt
	end
end

function love.load()
	love.graphics.setBackgroundColor(255,255,255)
	love.graphics.setColor(0,0,0)
end

function love.draw()
	if #particles == 0 then return end
	for x = 1, #particles do
		love.graphics.draw(particles[x].canvas, particles[x].x, particles[x].y,
			particles[x].angle, 1 + math.sin(particles[x].phase),
			1 + math.sin(particles[x].phase), particles[x].w/2, particles[x].h/2)
	end
end
