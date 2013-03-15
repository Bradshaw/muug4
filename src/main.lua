function love.load(arg)
	love.graphics.setDefaultImageFilter( "nearest", "nearest"  )
	love.graphics.setLine(1,"rough")
	require("useful")

	require("item")


	font = love.graphics.newImageFont("images/myfont.png",
    " abcdefghijklmnopqrstuvwxyz" ..
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
    "123456789.,!?-+/():;%_`'*__[]\"" ..
    "<>&#=$")
	--font = love.graphics.newFont("images/DisposableDroidBB.ttf",12)
    love.graphics.setFont(font)

	seq = require("sequence")
	local modes = love.graphics.getModes()
	table.sort(modes, function(a, b) return a.width*a.height < b.width*b.height end)
	local m = modes[#modes]
	local success = love.graphics.setMode( m.width, m.height, false )

	if not success then
		print("Failed to set mode")
		love.event.push("quit")
	end
	require("sparkle")
	pim = love.graphics.newImage("images/particle.png")
	sp = sparkle.new(pim, 20, 0.5, 0, math.floor(love.graphics.getHeight())/4, math.floor(love.graphics.getWidth())/4, math.floor(love.graphics.getHeight())/4, -math.pi/2, 20, 5, 0, 15, 1, {amp=0.5, speed=2}, 255, 200, 50)


	gstate = require "gamestate"

	local p = 1
	while love.filesystem.exists("pages/page"..p..".lua") do
		seq.new(require("pages/page"..p))
		p = p+1
	end
	seq.next()
	--seq.current = 20
	--gstate.switch(seq.pages[seq.current], seq.current)
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
