--main.lua
square = {}
squares = {}

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
	if #squares == 0 then return end
	for x = 1, #squares do
		squares[x].angle = squares[x].angle + math.pi * dt
		squares[x].phase = squares[x].phase + math.pi * dt
	end
end

function love.load()
	love.graphics.setBackgroundColor(255,255,255)
	love.graphics.setColor(0,0,0)
end
