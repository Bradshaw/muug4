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
	useful.print("Questions r<currentes\n\n"..
		" - A quoi bon?\n"..
		" - Est-ce que ca fait mal?\n"..
		" - Comment on fait?\n"..
		" - A quoi ca ressemble?\n\n"..
		" - Quelques id<es et questions...\n"
		,"center","center",0,-35,4)
	sparkle.draw(sp)
	love.graphics.setColor(255,255,255)
	love.graphics.pop()
end

return state