local state = gstate.new()
local time = 0

function state:init()
	require("dungeon")
	require("useful")
	dude = {}
	dude.x = 5.5
	dude.y = 5.5
	bnc = 0
	acc = 0
	d = dungeon.newMaze(21,21)
	map = {}
	vis = {}
	local att = 0
	while d:get(dude.x,dude.y)=="wall" and att<100 do
		dude.x = math.random(2,10)+0.5
		dude.y = math.random(2,10)+0.5
		att = att+1
	end
end


function state:enter()
	d = dungeon.newMaze(21,21)
    map = {}
    vis = {}
    local att = 0
    while d:get(dude.x,dude.y)=="wall" and att<100 do
      dude.x = math.random(2,10)+0.5
      dude.y = math.random(2,10)+0.5
      att = att+1
    end
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
	if key==" " or key=="return" then
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
	bnc = math.max(0,bnc+5*acc*dt)
	acc = acc - 50*dt
	local run = false
	if love.keyboard.isDown("left","q", "a") then
		run = true
		if d:get(dude.x-2*dt,dude.y)~="wall" then
			dude.x = dude.x-2*dt
		end
	end
	if love.keyboard.isDown("right","d") then
		run = true
		if d:get(dude.x+2*dt,dude.y)~="wall" then
			dude.x = dude.x+2*dt
		end
	end
	if love.keyboard.isDown("up","z","w") then
		run = true
		if d:get(dude.x,dude.y-2*dt)~="wall" then
			dude.y = dude.y-2*dt
		end
	end
	if love.keyboard.isDown("down","s") then
		run = true
		if d:get(dude.x,dude.y+2*dt)~="wall" then
			dude.y = dude.y+2*dt
		end
	end
	if run and bnc==0 then
		acc = 10
	end
end


function state:draw()

	love.graphics.push()
	love.graphics.scale(4,4)
	sparkle.draw(sp)
	love.graphics.pop()
	local scalex = 24
	local scaley = 16
	local scale = 4
	love.graphics.push()
	love.graphics.translate(math.floor(-dude.x*scalex)*scale, math.floor(-dude.y*scaley)*scale)
	love.graphics.translate(love.graphics.getWidth()/2,2*love.graphics.getHeight()/3)
	love.graphics.scale(scale,scale)
	for k,v in pairs(d.tiles) do
	for j,u in pairs(v) do
	  if u=="wall" then
	    love.graphics.setColor(60,60,60)
	  else
	    love.graphics.setColor(20,20,20)
	  end
	  --love.graphics.rectangle("fill",k*scale,j*scale,scale,scale)
	end
	end
	d:pretty(dude.x,dude.y,5, scalex, scaley)
	love.graphics.setColor(0,0,0,64)
	love.graphics.rectangle("fill",math.floor(dude.x*scalex-3.5),math.floor(dude.y*scaley-1.5),7,5)
	love.graphics.setColor(0,255,0)
	love.graphics.rectangle("fill",math.floor(dude.x*scalex-2.5),math.floor(dude.y*scaley-2.5-bnc),5,5)
	--love.graphics.print(d:get(dude.x,dude.y),dude.x*scale-2.5,dude.y*scaley-2.5)
	love.graphics.pop()


	love.graphics.push()
	love.graphics.scale(4,4)
	love.graphics.setColor(0,0,0)
	love.graphics.rectangle("fill",0,0,love.graphics.getWidth()/2,35)
	love.graphics.setColor(0,0,0,65)
	for i=1,10 do
		love.graphics.rectangle("fill",0,0,love.graphics.getWidth()/2,35+i*2)
	end
	love.graphics.setColor(255,255,255)
	useful.print("Donjon \"Rogue-like\"\n","center","top",-20,10,4)
	useful.print(" - Algorithme du labyrinthe\n","last","top",-20,25,4)
	love.graphics.setColor(255,255,255)
	love.graphics.pop()
end

return state