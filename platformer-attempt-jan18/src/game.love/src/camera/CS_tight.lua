-- parent
local CS = CS or require("src/camera/CS_camerastate")

-- constructor w/ protected member variables
CS_Tight = CS:new{
				default_y_offset_from_center = -0.25,
				target_y = nil,
				nextstate = nil
			}

-- includes
local CS_Interp = CS_Interp or require("src/camera/CS_interp")

function CS_Tight:update(dt, player)
	-- always follow the x-direction
	self.pos.x = player.gec_physics.pos.x - self.width / 2

	-- lock on to player y value until given a different target
	if (self.target_y) then
		self.pos.y = self.target_y - self.height / 2
	else
		self.pos.y = player.gec_physics.pos.y - self.height / 2
	end

	-- if player isn't moving in y-direction, interp camera to y-offset
	if (self.nextstate) then
		return CS_Interp:new{
			start=0,
			target=self.nextstate.target_y+self.default_y_offset_from_center,
			nextstate=self.nextstate
		}
	end

	return self
end

-- call this when player collides with camera-target region
function CS_Tight:target(target_y)
	self.nextstate = CS_Tight:new{
		target_y=target_y
	}
end

-- call this when player no longer collides with camera-target region
function CS_Tight:untarget()
	self:target(nil)
end

-- call this to tell if camera is targeting a region or not 
-- (if not, then it is targeting the player)
function CS_Tight:is_targeting()
	return self.target_y ~= nil
end

-- return the class
return CS_Tight