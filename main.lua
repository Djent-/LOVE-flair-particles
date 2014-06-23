--main.lua
square = {}
particles = {}

function square:new(x,y)
	local self = {}
	self.ID = #particles + 1
	self.x = x
	self.y = y
	self.x_mod = 0
	self.y_mod = 0
	self.x_angle = 0
	self.y_angle = 0
	local a = math.random(0,1)
	a = a - 1; if a == 0 then a = 1 end
	local b = math.random(0,1)
	b = b - 1; if b == 0 then b = 1 end
	self.random_x_direction = a
	self.random_y_direction = b
	self.w = 20
	self.h = 20
	self.angle = 0
	self.phase = 0
	self.canvas = love.graphics.newCanvas(40,40)
	love.graphics.setCanvas(self.canvas)
	love.graphics.rectangle("line", 0, 0, 40, 40)
	love.graphics.setCanvas()
	self.kill = function(self) table.remove(particles, self.ID) end
	return self
end

function love.update(dt)
	if love.timer.getTime() - timer > 0.1 then
		table.insert(particles, square:new(love.mouse.getPosition()))
		timer = love.timer.getTime()
	end
	if #particles == 0 then return end
	for x = 1, #particles do
		if particles[x] then
			particles[x].ID = x
			particles[x].x_angle = particles[x].x_angle + (math.pi / 8) * dt
			particles[x].y_angle = particles[x].y_angle + (math.pi / 8) * dt
			particles[x].angle = particles[x].angle + math.pi * dt
			particles[x].phase = particles[x].phase + math.pi * dt
		end
	end
	for x = 1, #particles do
		if particles[x] then
			if particles[x].phase > math.pi then
				particles[x]:kill()
			end
		end
	end
end

function love.load()
	love.graphics.setBackgroundColor(255,255,255)
	love.graphics.setColor(0,0,0)
	timer = love.timer.getTime()
end

function love.draw()
	love.graphics.print(love.timer.getTime(), 5, 5)
	love.graphics.print(timer, 5, 15)
	if #particles == 0 then return end
	for x = 1, #particles do
		love.graphics.draw(particles[x].canvas, particles[x].x + particles[x].x_mod,
			particles[x].y + particles[x].y_mod, particles[x].angle,
			1 + math.sin(particles[x].phase), 1 + math.sin(particles[x].phase),
			particles[x].w/2, particles[x].h/2)
	end
end
