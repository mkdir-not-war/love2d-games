-- includes
local GEC = GEC or require("src/gameentitycomponents/GEC_gameentitycomponent")

-- constructor w/ protected member variables
local GEC_Drawable = GEC:new{
					img = nil,
					width = nil,
					height = nil,
					direction = 1
				}

function GEC_Drawable:draw(x, y) 
	love.graphics.draw(
		self.img, 
		x - self.width/2 * -self.direction, 
		y - self.height, 
		0, 
		self.width/self.img:getWidth() * -self.direction, 
		self.height/self.img:getHeight())
end

-- return the class
return GEC_Drawable