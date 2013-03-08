local state = gstate.new()
local time = 0

function state:init()

end


function state:enter()

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
end


function state:draw()
	love.graphics.push()
	love.graphics.scale(4,4)
	love.graphics.setColor(255,255,255)
	useful.print("Comment on fait?\n","center","center",-20,-10,4)
	useful.print(" - D<finir le probl>me\n","last","center",-20,5,4)
	useful.print(" - D<finir le r<sultat souhait<\n","last","center",-20,15,4)
	sparkle.draw(sp)
	love.graphics.setColor(255,255,255)
	love.graphics.pop()
end

return state