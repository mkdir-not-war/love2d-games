-- parent
local CS = CS or require("src/camera/CS_camerastate")

-- constructor w/ protected member variables
local CS_Interp = CS:new{
					start = 0,
					target = 0,
					current = 0,
					speed = 0.01,
					speed_mod = 5.0,
					accel_mod = 0.1,
					nextstate = nil
				}

function CS_Interp:update(dt, player)
	-- always follow the x-direction
	self.pos.x = player.gec_physics.pos.x - self.width / 2

	-- exit condition
	if (self.current >= 1.0) then
		self.pos.y = player.gec_physics.pos.y + (-self.height / 2 - self.height * self.target)
		return self.nextstate
	else
		-- interpolate current from start to target
		if (self.current < 0.5) then
			self.speed = self.speed + self.accel_mod
		end
		self.current = self.current + self.speed * self.speed_mod * dt
		offset = self.start + self.current * (self.target - self.start)

		-- update position to offset away from player
		self.pos.y = player.gec_physics.pos.y + (-self.height / 2 - self.height * offset)
	end

	return self
end

-- return the class
return CS_Interp