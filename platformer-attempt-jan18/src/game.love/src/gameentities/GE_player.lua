-- parent
local GE = GE or require("src/gameentities/GE_gameentity")

-- includes
local GEC_Drawable = GEC_Drawable or require("src/gameentitycomponents/drawingcomponents/GEC_drawable")
local GEC_P_Actor = GEC_P_Actor or require("src/gameentitycomponents/physicscomponents/GEC_physics_actor")

-- constructor w/ protected static variables
local GE_Player = GE:new{
					gec_physics = GEC_P_Actor:new{	
						pos = {
							x = love.graphics.getWidth() / 2,
							y = love.graphics.getHeight() / 2
						},
						vel = {
							x = 0,
							y = 0
						}
					},
					gec_drawable = GEC_Drawable:new{
						img = love.graphics.newImage('res/textures/supfool.png'),
						width = 64,
						height = 64,
						direction = 1
					},
					canFireMagic = true,
					magicMaxTimer = 0.2,
					magicTimer = 0.2
				}

function GE_Player:fireMagic()

end

function GE_Player:update(dt)
	self.gec_physics:update(dt)

	return {}
end

-- return the class
return GE_Player