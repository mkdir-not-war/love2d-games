-- includes
local GEC = GEC or require("src/gameentitycomponents/GEC_gameentitycomponent")
local BoundingBox = BoundingBox or require("src/datastructures/boundingbox")

-- constructor w/ protected member variables
local GEC_Collidable = GEC:new{
					dynamic = false,
					permeable = true,
					boundingbox = nil,
					previouspos = {x=nil, y=nil}
				}

-- call this with all entities it collides with; implement in subclass
--[[
	Maybe only "dynamic" entity involve collision, 
	i.e. actors, projectile and desructibles.
	Each update, for each dynamic entity, find all colliding entities,
	and call those entities' onCollision methods with the dynamic entity.
]]--
function GEC_Collidable:onCollision(entity) end

-- call this in entity update loop if it has gec_collidable 
function GEC_Collidable:savePosition(prevpos)
	self.previouspos.x = prevpos.x
	self.previouspos.y = prevpos.y
end

-- return the class
return GEC_Collidable