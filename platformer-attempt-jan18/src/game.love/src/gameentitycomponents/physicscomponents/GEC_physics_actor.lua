-- includes
local GEC = GEC or require("src/gameentitycomponents/GEC_gameentitycomponent")

-- constructor w/ protected member variables
local GEC_Physics_Actor = GEC:new{
	pos = {
		x = nil,
		y = nil
	},
	vel = {
		x = nil,
		y = nil
	},
	speed = 200,
	jump_height = -960,
	gravity = -1800,
	ground = love.graphics.getHeight() -- delet this			
}

function GEC_Physics_Actor:update(dt) 
	-- apply y forces
	self.pos.y = self.pos.y + self.vel.y * dt
	self.vel.y = self.vel.y - self.gravity * dt

	-- apply x forces
	self.pos.x = self.pos.x + self.vel.x * (self.speed * dt)

	-- collide with ground
	if self.pos.y > self.ground then
		self.vel.y = 0
		self.pos.y = self.ground
	elseif self.pos.y == self.ground then
		--print("grounded")
	else
		--print("falling")
	end
end

-- return the class
return GEC_Physics_Actor