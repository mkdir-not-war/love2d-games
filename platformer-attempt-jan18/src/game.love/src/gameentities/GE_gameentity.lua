GameEntity = {
	gec_physics = nil,
	gec_drawable = nil,
	gec_collidable = nil
}

function GameEntity:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function GameEntity:load(args)
	-- use to assign values into components??
end

function GameEntity:update(dt) 
	-- return list of any new entities to add
	return {}
end

function GameEntity:draw(x, y) 
	if self.gec_drawable then
		self.gec_drawable:draw(x, y)
	end
end

return GameEntity