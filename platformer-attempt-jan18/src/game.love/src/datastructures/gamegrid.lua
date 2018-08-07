GameGrid = {
	height = nil,
	width = nil,
	box_width = 64
}

function GameGrid:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function GameGrid:get_position(x, y)
	return {
		x = box_width * x, 
		y = box_width * y
	}
end

return GameGrid