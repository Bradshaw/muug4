item = {}

math.randomseed(os.time())

item.adjectives = {}
item.adjectives[1] = {word="Lousy",		speed=0,	power=0,	size=0,		level=0}
item.adjectives[2] = {word="Flimsy",	speed=0,	power=0,	size=0,		level=0}
item.adjectives[3] = {word="Broken",	speed=0,	power=0,	size=0, 	level=0}
item.adjectives[4] = {word="Bouncy",	speed=1,	power=0,	size=0,		level=1}
item.adjectives[5] = {word="Shattered",	speed=0,	power=1,	size=0,		level=1}
item.adjectives[6] = {word="Unwieldy",	speed=0,	power=0,	size=1,		level=1}
item.adjectives[7] = {word="Spiky",		speed=0,	power=2,	size=0,		level=2}
item.adjectives[8] = {word="Nasty",		speed=1,	power=1,	size=0,		level=2}
item.adjectives[9] = {word="Bulky",		speed=0,	power=1,	size=1,		level=2}
item.adjectives[10] = {word="Nimble",	speed=2,	power=0,	size=0,		level=2}
item.adjectives[11] = {word="Slashing",	speed=1,	power=1,	size=1,		level=2}
item.adjectives[12] = {word="Oversized",speed=0,	power=0,	size=2,		level=2}
item.adjectives[13] = {word="Quixotic",	speed=1,	power=1,	size=1,		level=2}
item.adjectives[14] = {word="Tiny",		speed=12,	power=0,	size=0,		level=3}

item.types = {}
item.types[1]="Sword"
item.types[2]="Pike"
item.types[3]="Wand"
item.types[4]="Bow"
item.types[5]="Shield"

item.styles = {}
item.styles[1] = {word="Fail",			speed=0.5,	power=0.5,	size=0.5,	level=0.5}
item.styles[2] = {word="Slicing",		speed=1.3,	power=1.2,	size=0.9,	level=1}
item.styles[3] = {word="Wisdom",		speed=0.7,	power=2,	size=0.7,	level=1.4}
item.styles[4] = {word="Power",			speed=0.7,	power=2,	size=2,		level=2}
item.styles[5] = {word="Insanity",		speed=2,	power=0.8,	size=1,		level=1.6}
item.styles[6] = {word="Grinding",		speed=1.5,	power=1,	size=1.5,	level=1.5}
item.styles[7] = {word="Agility",		speed=3,	power=0.5,	size=0.5,	level=1}
item.styles[8] = {word="Retard",		speed=12,	power=1,	size=0.2,	level=1.5}

item.image={}
for i=1,#item.types do
	item.image[i]=love.graphics.newImage("images/"..item.types[i]..".png")
	item.image[i]:setFilter("nearest", "nearest")

end

function item.new(level, adj, typ, sty)
	local it = {}
	level = level or math.random(1,10)
	it.adj = adj or math.random(1,#item.adjectives)
	it.typ = typ or math.random(1,#item.types)
	it.sty = sty or math.random(1,#item.styles)
	it.level = math.floor((level + item.adjectives[it.adj].level) * item.styles[it.sty].level)
	it.speed = math.floor((3+item.adjectives[it.adj].speed)*(level*item.styles[it.sty].speed)+math.random(1,level))
	it.power = math.floor((3+item.adjectives[it.adj].power)*(level*item.styles[it.sty].power)+math.random(1,level))
	it.size = math.floor((3+item.adjectives[it.adj].size)*(level*item.styles[it.sty].size)+math.random(1,level))
	it.name=item.adjectives[it.adj].word .. " " .. item.types[it.typ] .. " of " .. item.styles[it.sty].word
	return it
end

function item.draw(e)
	love.graphics.setColor(255,255,255)
	love.graphics.draw(item.image[e.item.typ], math.floor(e.x*tilesizex), math.floor(e.y*tilesizey), 0, 1, 1, item.image[e.item.typ]:getWidth()/2, item.image[e.item.typ]:getHeight() )
end

function item.attacktime(w)
	if w.typ == 1 then
		return 0.2 + 2/w.speed
	end
	return 6
end 

function item.attack(e, dir, atx, aty)
	--display.message(e.name)
	item.wepattack[e.typ](e, dir, atx, aty)
end

item.wepattack = {}

item.wepattack[1]= function(e, dir, atx, aty) -- Sword
	--display.message(dir.. " " .. math.floor(atx).. " " .. math.floor(aty).. " " .. math.floor(p.x).. " " .. math.floor(p.y))
	local el = entlist.prox(ents, atx, aty)
	for i=1,#el do
		local dist = useful.distance(atx, aty, el[i].x, el[i].y)
		if el[i].type=="mob" and (not el[i].dead) and dist<0.7 then
			--display.message("Hit " .. (e.power*dist))
			mob.takedmg(el[i], (e.power*(2-dist))*10)
			mob.pushback(el[i], dir, (e.power*(2-dist))/10)
		end
	end
	local dtx = math.floor(atx*tilesizex + math.random(-2, 2))
	local dty = math.floor(aty*tilesizey + math.random(-2, 2))
	local fx = (math.random(0,1)-0.5)*2
	local fy = (math.random(0,1)-0.5)*2
	dis.add(drawlist, aty, function()
		love.graphics.setColor(255,255,255)
		love.graphics.draw(slash[math.random(1,3)], dtx, dty, rot, fx, fy, 4, 4)
	end)
end

item.wepattack[2]= function(e, dir, atx, aty) -- Pike
	
end

item.wepattack[3]= function(e, dir, atx, aty) -- Wand
end

item.wepattack[4]= function(e, dir, atx, aty) -- Bow
end

item.wepattack[5]= function(e, dir, atx, aty) -- Shield
end
