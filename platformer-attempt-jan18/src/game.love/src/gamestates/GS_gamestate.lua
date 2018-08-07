GameState = {}

function GameState:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function GameState:load(args) end

function GameState:handleinput_kp(key) end

function GameState:handleinput_kr(key) end

function GameState:update(dt)
	-- if state changes, return the new state 
	return self
end

function GameState:draw() end

return GameState