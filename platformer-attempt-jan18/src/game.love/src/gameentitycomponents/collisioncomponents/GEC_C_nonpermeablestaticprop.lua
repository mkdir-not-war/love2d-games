-- includes
local GEC_Collidable = GEC_Collidable or require("src/gameentitycomponents/collisioncomponents/GEC_collidable")

-- constructor w/ protected member variables
local GEC_C_NonPermeableStaticProp = GEC_Collidable:new{
					permeable = false,
					dynamic = false
				}

-- call this with all entities it collides with; implement in subclass
--[[
	Maybe only "dynamic" entity involve collision, 
	i.e. actors, projectile and desructibles.
	Each update, for each dynamic entity, find all colliding entities,
	and call those entities' onCollision methods with the dynamic entity.
]]--
function GEC_Collidable:onCollision(entity) 
	-- if the colliding entity is collidable and dynamic,
	-- send it to its previous position
	if (entity.gec_collidable and entity.gec_collidable.dynamic) then
		entity.pos = entity.gec_collidable.previouspos
	end
end

-- return the class
return GEC_C_NonPermeableStaticProp