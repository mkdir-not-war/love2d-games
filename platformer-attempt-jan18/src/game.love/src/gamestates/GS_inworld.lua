-- parent
local GameState = GameState or require("src/gamestates/GS_gamestate")

-- constructor w/ protected member variables
local GS_InWorld = GameState:new{entities = {}, nextstate = nil}

-- includes
local IH_InWorld = require("src/inputhandlers/IH_inworld")

local GE_Player = require("src/gameentities/GE_player")
local Camera = require("src/camera/CS_tight")
local GameGrid = require("src/datastructures/gamegrid")

-- entities; move these to map loader eventually
local GE_BasicBlock = require("src/gameentities/GE_basicblock")

-- local (private) variables
local t = 0
local inputhandler = {}
local camera = {}
local background = {}
local gamegrid = {}

-- functions
function GS_InWorld:load(args) 

	if (args and args.GS_inworld) then
		-- if args includes a GS_InWorld (i.e. from unpausing), copy that

	else 
		-- setup handlers, variables and camera -------------------------
		-- set the clock
		t = 0

		-- set the handlers
		inputhandler = IH_InWorld:new()

		-- camera is map-agnositc
		camera = Camera:new()

		-- the next state should initially be self until otherwise
		self.nextstate = self

		-- load the map
		self:loadmap()
	end

end

function GS_InWorld:loadmap(filename)
	-- initialize a new gamegrid/map
	gamegrid = GameGrid:new()
	gridbox_width = gamegrid.box_width

	-- initialize entities list with player at zero
	self.entities = {}
	self.entities[0] = GE_Player:new{
		pos = {	x = love.graphics.getWidth() / 2,
				y = love.graphics.getHeight() / 2
			}
		}

	-- set the background image
	background = love.graphics.newImage('res/textures/ghibli-bg.jpg')
	gimg = background
	
	-- set the blocks
	--gimg = love.graphics.newImage('res/textures/block.jpg')
	for i=1,4 do
		self.entities[i] = GE_BasicBlock:new{}
		self.entities[i]:load{
			gridbox_width=gridbox_width,
			x=i,
			y=1
		}
		print(self.entities[i].gec_physics)
	end

	for i=0,4 do
		print(self.entities[i].gec_physics.pos.x)
	end
	--error()
end

function GS_InWorld:handleinput_kp(key)
	inputhandler:handle_kp(key, {
		gamestate = self
	})
end

function GS_InWorld:handleinput_kr(key)
	inputhandler:handle_kr(key, {
		gamestate = self
	})
end

function GS_InWorld:update(dt) 

	-- update entities
	for k, v in pairs(self.entities) do
		-- each entity can spawn new entities
		local newentities = v:update(dt)

		-- add any new entities to master list 
		for i=1, #newentities do
			self.entities[#self.entities+1] = newentities[i]
		end
	end

	-- update the camera
	camera = camera:update(dt, self.entities[0])

	-- check conditions for state change
	if (false) then end

	return self.nextstate
end

function GS_InWorld:draw() 
	-- draw background
	love.graphics.draw(
		background, 
		0, 
		0, 
		0, 
		love.graphics.getHeight()/background:getHeight() * background:getWidth()/background:getHeight(),
		love.graphics.getHeight()/background:getHeight())

	for k, v in pairs(self.entities) do
		--[[
			When drawing, keep in mind that the position of the 
			entity is on its bottom-most edge in the center, so 
			it needs to be drawn at 
			<posx - (width/2 * -direction), posy - height>
			For entities without direction, the direction should just be 1.
			This logic is all done inside the definition of GE_Drawable.
		]]--

		-- determine position relative to camera
		relx = v.gec_physics.pos.x - camera.pos.x
		rely = v.gec_physics.pos.y - camera.pos.y

		-- if collides with camera and drawable entity
		if (true) then
			-- draw the object at relative position
			v:draw(relx, rely)
		end
	end

	
	scale = 256
	for i=0,5 do
		love.graphics.draw(
			gimg, 
			i*scale - camera.pos.x,
			love.graphics.getHeight() - camera.pos.y,
			0, 
			scale/gimg:getWidth(), 
			scale*(gimg:getHeight()/gimg:getWidth())/gimg:getHeight())
	end
	
end

-- return the class
return GS_InWorld