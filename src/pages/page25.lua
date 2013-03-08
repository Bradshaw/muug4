local state = gstate.new()
local time = 0

function state:init()

end


function state:enter()
	it = item.new()
	drop = 0
	height = 10
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
	drop = drop+dt*100
	height = height-drop*dt
	if height<=0 then
		height=0
		drop = -drop*0.75
	end
	time = time+dt
	sparkle.update(sp, dt)
end


function state:draw()
	love.graphics.push()
	love.graphics.scale(4,4)
	love.graphics.setColor(255,255,255)
	useful.print("Phat loot!","center","top",-20,10,4)
	useful.print(" - Contacter Blizzard\n","last","top",-20,25,4)
	useful.print("lvl "..it.level.." "..item.adjectives[it.adj].word.." "..item.types[it.typ].." of "..item.styles[it.sty].word,"center","center",math.cos(time*7)*2,math.sin(time*14),4)
	useful.print("Atk: "..it.speed,"center","center",0,15,4)
	useful.print("Pow: "..it.power,"last","center",0,25,4)
	useful.print("Def: "..it.size,"last","center",0,35,4)
	love.graphics.draw(item.image[it.typ],lasthalign - 20, love.graphics.getHeight()/8+17-math.floor(height))
	--print("Atk: "..it.speed)
	--print("Pow: "..it.power)
	--print("Def: "..it.size)
	sparkle.draw(sp)
	love.graphics.setColor(255,255,255)
	love.graphics.pop()
end

return state