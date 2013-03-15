local state = gstate.new()
local time = 0

function state:init()
	require("modlevel")
end


function state:enter()
	l = {}
	local p = 1
	while love.filesystem.exists("modlevel/mod"..p..".lua") do
		l[p] = modlevel.new("modlevel/mod"..p..".lua")
		p = p+1
	end
	--l[#l+1] = modlevel.new("modlevel/cap.lua")
	--l[#l+1] = modlevel.new("modlevel/corridor.lua")
	r = math.random(1,#l)
	l[r]:center()
	for i=1,1 do
		local cap = modlevel.new("modlevel/mod"..math.random(1,#l)..".lua")
		l[r]:append(cap)
	end
	l[r]:center()
	--l[r]:undoorify()
	modlevel.scale = 25
end


function state:focus()

end


function state:mousepressed(x, y, btn)

end


function state:mousereleased(x, y, btn)
	
end


function state:joystickpressed(joystick, button)
	
end


function state:joystickreleased(joystick, button)
	
end


function state:quit()
	
end


function state:keypressed(key, uni)
	if key=="escape" then
		love.event.push("quit")
	end
	if key=="down" then
		seq.reload()
	end
	if key=="right" then
		seq.next()
	end
	if key=="left" then
		seq.previous()
	end
end


function state:keyreleased(key, uni)
	
end


function state:update(dt)
	time = time+dt
	sparkle.update(sp, dt)
	l[r]:rotate(dt/8)
end


function state:draw()
	love.graphics.push()
	love.graphics.scale(4,4)
	love.graphics.setColor(255,255,255)
	useful.print("\"Doom-like\" modulaire\n","center","top",-20,10,4)
	useful.print(" - Les combiner\n","last","top",-20,25,4)
	sparkle.draw(sp)
	love.graphics.setColor(255,255,255)
	love.graphics.pop()

	love.graphics.push()
	--love.graphics.scale(40,40)
	love.graphics.translate(love.graphics.getWidth()/2,2*love.graphics.getHeight()/3)
	l[r]:draw(true)
	love.graphics.pop()
end

return state