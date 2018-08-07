local InputHandler = InputHandler or require("src/inputhandlers/IH_inputhandler")

-- adjacent game states
local gs_pausemenu = require("src/gamestates/GS_pausemenu")

-- constructor
local IH_InWorld = InputHandler:new{}

-- variables for tuning
local jump_dampen_scale = 20

-- variables for input handling
local commands2keys = {
	moveleft = 'a',
	moveright = 'd',
	jump = 'w',
	pause = 'escape'
}
commands2keys.stopleft = commands2keys["moveleft"]
commands2keys.stopright = commands2keys["moveright"]
commands2keys.stopjump = commands2keys["jump"]

local kp_commands = {}
kp_commands[commands2keys.moveleft] = "command_moveleft"
kp_commands[commands2keys.moveright] = "command_moveright"
kp_commands[commands2keys.jump] = "command_jump"
kp_commands[commands2keys.pause] = "command_pausemenu"

local kr_commands = {}
kr_commands[commands2keys.stopleft] = "command_stopleft"
kr_commands[commands2keys.stopright] = "command_stopright"
kr_commands[commands2keys.stopjump] = "command_stopjump"

--[[ CALLBACKS ]]--
function IH_InWorld:handle_kp(key, args)
	-- convert key into command
	if (kp_commands[key]) then
		self[kp_commands[key]](self, args)
	end
end

function IH_InWorld:handle_kr(key, args)
	-- convert key into command
	if (kr_commands[key]) then
		self[kr_commands[key]](self, args)
	end
end

--[[ COMMANDS ]]--

function IH_InWorld:command_pausemenu(args)
	love.event.quit() ------------------------------------------------- auto quits
	--gs_pausemenu:load{gamestate=args.gamestate}
	--gamestate.nextstate = gs_pausemenu
end

function IH_InWorld:command_moveleft(args)
	local player = args.gamestate.entities[0]
	player.gec_physics.vel.x = -1
	player.gec_drawable.direction = -1
end

function IH_InWorld:command_moveright(args)
	local player = args.gamestate.entities[0]
	player.gec_physics.vel.x = 1
	player.gec_drawable.direction = 1
end

function IH_InWorld:command_stopleft(args)
	local player = args.gamestate.entities[0]
	if love.keyboard.isDown(commands2keys.moveright) then
		player.gec_physics.vel.x = 1
		player.gec_drawable.direction = 1
	else
		player.gec_physics.vel.x = 0
	end
end

function IH_InWorld:command_stopright(args)
	local player = args.gamestate.entities[0]
	if love.keyboard.isDown(commands2keys.moveleft) then
		player.gec_physics.vel.x = -1
		player.gec_drawable.direction = -1
	else
		player.gec_physics.vel.x = 0
	end
end

function IH_InWorld:command_jump(args)
	local player = args.gamestate.entities[0]
	if player.gec_physics.pos.y == player.gec_physics.ground then
		player.gec_physics.vel.y = player.gec_physics.jump_height
	end
end

function IH_InWorld:command_stopjump(args)
	local player = args.gamestate.entities[0]
	if player.gec_physics.vel.y <= 0 then
		-- dampen the jump significantly
		player.gec_physics.vel.y = player.gec_physics.vel.y / jump_dampen_scale
	end
end

--[[
function love.keypressed(key)
	if key == fireball.input then
		if player.canFireMagic then
			player.canFireMagic = false
			spawnFireball(player.x + player.direction * 10,
						player.y - player.height/2,
						player.direction)
		end
	elseif key == 'escape' then
		love.event.quit()
	end
end
]]--

return IH_InWorld