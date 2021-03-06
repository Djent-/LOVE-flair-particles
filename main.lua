--main.lua
square = {}
particles = {}

function square:new(x,y)
	local self = {}
	self.ID = #particles + 1
	self.x = x
	self.y = y
	self.x_mod = 20
	self.y_mod = 20
	self.x_angle = 0
	self.y_angle = 0
	local a = math.random(0,1)
	local b = math.random(0,1)
	self.random_x_direction = a
	self.random_y_direction = b
	self.w = 10
	self.h = 10
	self.angle = 0
	self.phase = 0
	self.canvas = love.graphics.newCanvas(self.w, self.h)
	love.graphics.setCanvas(self.canvas)
	love.graphics.rectangle("line", 0, 0, self.w, self.h)
	love.graphics.setCanvas()
	self.kill = function(self) table.remove(particles, self.ID) end
	self.draw = function(self)
			love.graphics.draw(self.canvas, self.x_draw,
				self.y_draw, self.angle,
				1 + math.sin(self.phase), 1 + math.sin(self.phase),
				self.w/2, self.h/2)
		end
	self.update = function(self, dt)
			if self.random_x_direction < 1 then
				self.x_draw = self.x - (math.sin(self.x_angle) * self.x_mod)
			else
				self.x_draw = self.x + (math.sin(self.x_angle) * self.x_mod)
			end
			self.x_mod = self.x_mod + (dt * 30)
			if self.random_y_direction < 1 then
				self.y_draw = self.y - (math.cos(self.y_angle) * self.y_mod)
			else
				self.y_draw = self.y + (math.cos(self.y_angle) * self.y_mod)
			end
			self.y_mod = self.y_mod + (dt * 30)
		end
	self:update(0)
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
			particles[x].x_angle = particles[x].x_angle + (math.pi) * dt
			particles[x].y_angle = particles[x].y_angle + (math.pi) * dt
			particles[x].angle = particles[x].angle + math.pi * dt
			particles[x].phase = particles[x].phase + math.pi * dt
			particles[x]:update(dt)
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
	if #particles == 0 then return end
	for x = 1, #particles do
		particles[x]:draw()
	end
end
