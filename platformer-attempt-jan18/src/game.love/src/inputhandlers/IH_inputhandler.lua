InputHandler = {}

function InputHandler:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function InputHandler:handle_kp(key, args) end

function InputHandler:handle_kr(key, args) end

return InputHandler