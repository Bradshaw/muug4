function love.load(arg)
	seq = require("sequence")
	local modes = love.graphics.getModes()
	table.sort(modes, function(a, b) return a.width*a.height < b.width*b.height end)
	local m = modes[#modes]
	local success = love.graphics.setMode( m.width, m.height, true )
	gstate = require "gamestate"
	local p = 1
	while love.filesystem.exists("pages/page"..p..".lua") do
		seq.new(require("pages/page"..p))
		p = p+1
	end
	seq.next()
end


function love.focus(f)
	gstate.focus(f)
end

function love.mousepressed(x, y, btn)
	gstate.mousepressed(x, y, btn)
end

function love.mousereleased(x, y, btn)
	gstate.mousereleased(x, y, btn)
end

function love.joystickpressed(joystick, button)
	gstate.joystickpressed(joystick, button)
end

function love.joystickreleased(joystick, button)
	gstate.joystickreleased(joystick, button)
end

function love.quit()
	gstate.quit()
end

function love.keypressed(key, uni)
	gstate.keypressed(key, uni)
end

function keyreleased(key, uni)
	gstate.keyreleased(key)
end

function love.update(dt)
	gstate.update(dt)
end

function love.draw()
	gstate.draw()
end
