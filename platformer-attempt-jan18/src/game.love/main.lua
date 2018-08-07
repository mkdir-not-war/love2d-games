--[[
	https://love2d.org/wiki/Tutorial:Networking_with_UDP
]]--

--local gamestate = require("src/GS_Init")
local gamestate = require("src/gamestates/GS_inworld")

-- variables for timing the updates
local updaterate = 0.018
local t

local img

function love.load(arg)
	gamestate:load()

	-- set the clock
	t = 0
end

function love.keypressed(key)
	-- allow the gamestate to handle the input
	gamestate:handleinput_kp(key)
end

function love.keyreleased(key)
	-- allow the gamestate to handle the input
	gamestate:handleinput_kr(key)
end

function love.update(dt)
	t = t + dt

	if t > updaterate then
		-- call gamestate's update, changing state if appropriate
		-- pass in t instead of dt for more consistent deltas
		local newgamestate = gamestate:update(t)
		if newgamestate ~= gamestate then
			gamestate = newgamestate
			newgamestate:load()
		end 
 	
 		-- set t for the next round
		t = t - updaterate 
	end
end

function love.draw()
	gamestate:draw()
end

function love.quit()
end
