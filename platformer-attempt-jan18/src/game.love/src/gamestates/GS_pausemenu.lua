-- parent
local GameState = GameState or require("src/gamestates/GS_gamestate")

-- constructor
local GS_PauseMenu = GameState:new{}

-- includes
local IH_PauseMenu = require("src/inputhandlers/IH_pausemenu")

-- variables
local inputhandler = {}

-- functions
function GS_PauseMenu:load(args) 
	-- set the input handler
	inputhandler = IH_PauseMenu:new()

	-- save the state of the game
	--------------------------------------------------------???
end

function GS_PauseMenu:handleinput_kp(key)
	inputhandler:handle_kp(key, {
		gamestate = self
	})
end

function GS_PauseMenu:handleinput_kr(key)
	inputhandler:handle_kr(key, {
		gamestate = self
	})
end

function GS_PauseMenu:update(dt) 
	return self
end

function GS_PauseMenu:draw() 
	--love.graphics.setColor(0.9, 0.63, 0.05)
	love.graphics.print('hello world', 10, 10)
	for k, v in pairs(entities) do
		--love.graphics.print(k, v.x, v.y)
		love.graphics.draw(img, 
			v.x, v.y, 0, 
			64/img:getWidth(), 
			64/img:getHeight(), 
			0, 32)
	end
end

-- return the class
return GS_PauseMenu