local InputHandler = InputHandler or require("src/inputhandlers/IH_inputhandler")

local IH_PauseMenu = InputHandler:new{}

function IH_PauseMenu:handle_kp(key, args)
	local gamestate = args.gamestate
	-- convert key into command

	-- update the gamestate entity list
end

function IH_PauseMenu:handle_kr(key, args)
	-- convert key into command

	-- update the gamestate entity list
end

--[[ COMMANDS ]]--

function IH_PauseMenu:command_quit()

end

function IH_PauseMenu:command_unpause()

end

return IH_PauseMenu