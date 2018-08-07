-- parent
local GameEntity = GameEntity or require("src/gameentities/GE_gameentity")

-- includes
local GEC_Drawable = GEC_Drawable or require("src/gameentitycomponents/drawingcomponents/GEC_drawable")
local GEC_C_NPSP = GEC_C_NPSP or require("src/gameentitycomponents/collisioncomponents/GEC_C_nonpermeablestaticprop")
local BoundingBox = BoundingBox or require("src/datastructures/boundingbox")
local GEC_P_Nil = GEC_P_Nil or require("src/gameentitycomponents/physicscomponents/GEC_physics_nil")

-- constructor w/ protected static variables
local GE_BasicBlock = GameEntity:new{
	gec_physics = GEC_P_Nil:new{
		x = nil,
		y = nil
	},
	gec_drawable = GEC_Drawable:new{
		img = love.graphics.newImage('res/textures/block.jpg'),
		width = 1,
		height = 1
	},
	gec_collidable = GEC_C_NPSP:new{
		boundingbox = BoundingBox:new{
			x = nil,
			y = nil,
			width = 1,
			height = 1
		}
	}
}

function GE_BasicBlock:load(args)
	if (args.gridbox_width == nil or
		args.x == nil or
		args.y == nil) then
		error("BasicBlock loaded with insufficient args")
	end
	self.gec_physics.pos.x = args.x * args.gridbox_width
	self.gec_physics.pos.y = args.y * args.gridbox_width
	self.gec_drawable.width = args.gridbox_width
	self.gec_drawable.height = args.gridbox_width
	self.gec_collidable.boundingbox.x = args.x * args.gridbox_width
	self.gec_collidable.boundingbox.y = args.y * args.gridbox_width
	self.gec_collidable.boundingbox.width = args.gridbox_width
	self.gec_collidable.boundingbox.height = args.gridbox_width

	if (args.img ~= nil) then
		self.gec_drawable.img = args.img
	end
end

-- return the class
return GE_BasicBlock