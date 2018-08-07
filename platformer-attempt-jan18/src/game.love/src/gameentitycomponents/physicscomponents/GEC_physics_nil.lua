-- includes
local GEC = GEC or require("src/gameentitycomponents/GEC_gameentitycomponent")

-- constructor w/ protected member variables
local GEC_Physics_Nil = GEC:new{
	pos = {
		x = nil,
		y = nil
	}				
}

function GEC_Physics_Nil:update(dt) 
	return
end

-- return the class
return GEC_Physics_Nil