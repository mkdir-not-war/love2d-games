BoundingBox = {
	x=nil,
	y=nil,
	width = nil,
	height = nil,
	subboxes = nil
}
-- position may be different from physical position, especially subboxes

function BoundingBox:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

-- assume no rotation
local function intersect_rect(a, b)
	return (a.x + a.width > b.x and 
		a.x < b.x + b.width and 
		a.y < b.y + b.height and
		a.y + a.height > b.y)
end

function BoundingBox:collision(bb)
	if (intersect_rect(self, bb)) then

		-- collide with current box
		if self.subboxes == nil then
			return true
		else
			-- check subboxes for true collision
			for k, subbox in pairs(self.subboxes) do
				if subbox:collision(bb) then
					return true
				end
			end
		end
	end
	return false
end

function BoundingBox:nearmiss(bb)
	if (intersect_rect(self, bb)) then

		-- collide with current box
		if self.subboxes == nil then
			return false
		else
			return true
		end
	end
end

return BoundingBox