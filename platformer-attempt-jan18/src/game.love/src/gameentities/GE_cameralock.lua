-- parent
local GE_Prop = GE_Prop or require("src/gameentities/GE_prop")

-- includes
local GEC_Drawable = GEC_Drawable or require("src/gameentitycomponents/drawingcomponents/GEC_drawable")
local GEC_Collidable = GEC_Collidable or require("src/gameentitycomponents/collisioncomponents/GEC_collidable")
local BoundingBox = BoundingBox or require("src/datastructures/boundingbox")
local GEC_P_Nil = GEC_P_Nil or require("src/gameentitycomponents/physicscomponents/GEC_physics_nil")

-- constructor w/ protected static variables
local GE_CameraLock = GE_Prop:new{
	gec_physics = GEC_P_Nil:new{
		x = nil,
		y = nil
	},
	gec_drawable = GEC_Drawable:new{
		img = love.graphics.newImage('res/textures/fancyframe.png'),
		width = nil,
		height = nil
	},
	gec_collidable = GEC_Collidable:new{
		dynamic = false,
		permeable = true,
		boundingbox = BoundingBox:new{
			x = nil,
			y = nil,
			width = nil,
			height = nil
		}
	}
}

function GE_CameraLock:load{args}
	if (args.gridbox_width == nil or
		args.x == nil or
		args.y == nil or
		args.width == nil or
		args.height == nil) then
		error("CameraLock loaded with insufficient args")
	end

	self.gec_physics.x = args.x * args.gridbox_width
	self.gec_physics.y = args.y * args.gridbox_width
	self.gec_drawable.width = args.width * args.gridbox_width
	self.gec_drawable.height = args.height * args.gridbox_width
	self.gec_collidable.boundingbox.x = args.x * args.gridbox_width
	self.gec_collidable.boundingbox.y = args.y * args.gridbox_width
	self.gec_collidable.boundingbox.width = args.width * args.gridbox_width
	self.gec_collidable.boundingbox.height = args.height * args.gridbox_width
end

-- return the class
return GE_CameraLock