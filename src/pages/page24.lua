local state = gstate.new()
local time = 0

function state:init()
	adjlist = "Adjectifs: \n"
	for i,v in ipairs(item.adjectives) do
		adjlist = adjlist.." - "..v.word.."\n"
	end
	adjlist = adjlist.."\nStyles: \n"
	for i,v in ipairs(item.styles) do
		adjlist = adjlist.." - "..v.word.."\n"
	end
end


function state:enter()
	time = 0
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
	useful.print(adjlist,"center","bottom",0,-time*10,4)
	love.graphics.setColor(0,0,0)
	love.graphics.rectangle("fill",0,0,love.graphics.getWidth()/2,35)
	love.graphics.setColor(0,0,0,65)
	for i=1,10 do
		love.graphics.rectangle("fill",0,0,love.graphics.getWidth()/2,35+i*2)
	end
	love.graphics.setColor(255,255,255)
	useful.print("Phat loot!","center","top",-20,10,4)
	useful.print(" - Cr<er des mots\n","last","top",-20,25,4)
	sparkle.draw(sp)
	love.graphics.setColor(255,255,255)
	love.graphics.pop()
end

return state