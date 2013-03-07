local state = gstate.new()

function state:init()
	require("maze")
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

end


function state:draw()
	love.graphics.print("This is page one!",20,20)
end

return state