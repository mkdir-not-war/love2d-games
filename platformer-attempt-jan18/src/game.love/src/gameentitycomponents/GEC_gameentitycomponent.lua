GameEntityComponent = {}

function GameEntityComponent:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function GameEntityComponent:update(dt) 
end

function GameEntityComponent:draw(x, y) 
end

return GameEntityComponent