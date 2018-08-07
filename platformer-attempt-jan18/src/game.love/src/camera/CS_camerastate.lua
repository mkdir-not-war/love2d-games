Camera = {
			height = love.graphics.getHeight(),
			width = love.graphics.getWidth(),
			pos = {
				x = 0,
				y = 0
			}
		}

function Camera:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function Camera:update(dt, player)
	-- return new camera state
	return self
end

-- return the class
return Camera