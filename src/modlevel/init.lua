local modlevel_mt = {}
modlevel = {}

modlevel.scale = 20

function modlevel.new(initfile)
	local levl
	local ok, chunk, result
	if love.filesystem.exists(initfile) then
		ok, chunk = pcall( love.filesystem.load, initfile ) -- load the chunk safely
		if not ok then
		  print('The following error happend: ' .. tostring(chunk))
		else
		  ok, levl = pcall(chunk) -- execute the chunk safely
		end
	end
	--print(levl)
	levl.name = initfile
	setmetatable(levl,{__index=modlevel_mt})
	return  levl,chunk
end

function modlevel_mt.undoorify(self)

	for i,v in ipairs(self) do
		--local cap = modlevel.new("modlevel/cap.lua")
		v.door=false

	end
end

function modlevel_mt.center(self)
	local minx = self[1][1]
	local miny = self[1][2]
	local maxx = self[1][1]
	local maxy = self[1][2]
	for i,v in ipairs(self) do
		minx = math.min(minx,v[1])
		maxx = math.max(maxx,v[1])
		miny = math.min(miny,v[2])
		maxy = math.max(maxy,v[2])
	end
	local dx = (minx+maxx)/2
	local dy = (miny+maxy)/2
	for i,v in ipairs(self) do
		v[1] = v[1]-dx
		v[2] = v[2]-dy
	end
end

function modlevel_mt.append(self, lvl, asel, bsel)
	lvl:center()
	local adoors = {}
	local bdoors = {}
	local last = {}
	last[1] = self[#self][1]
	last[2] = self[#self][2]
	last.door = self[#self].door
	for i,v in ipairs(self) do
		if last.door then
			adoors[#adoors+1] = {i=((i-2)%#self)+1,x1=v[1],y1=v[2],x2=last[1],y2=last[2]}
		end
		last[1] = v[1]
		last[2] = v[2]
		last.door = v.door
	end
	last[1] = self[#self][1]
	last[2] = self[#self][2]
	last.door = lvl[#lvl].door
	for i,v in ipairs(lvl) do
		if last.door then
			bdoors[#bdoors+1] = {i=((i-2)%#lvl)+1,x1=v[1],y1=v[2],x2=last[1],y2=last[2]}
		end
		last[1] = v[1]
		last[2] = v[2]
		last.door = v.door
	end
	local ad = adoors[asel or math.random(1,#adoors)]
	local bd = bdoors[bsel or math.random(1,#bdoors)]

	ad.dx = ad.x2-ad.x1
	ad.dy = ad.y2-ad.y1
	ad.len = math.sqrt(ad.dx*ad.dx+ad.dy*ad.dy)
	ad.dx = ad.dx/ad.len
	ad.dy = ad.dy/ad.len

	bd.dx = bd.x2-bd.x1
	bd.dy = bd.y2-bd.y1
	bd.len = math.sqrt(bd.dx*bd.dx+bd.dy*bd.dy)
	bd.dx = bd.dx/bd.len
	bd.dy = bd.dy/bd.len

	print(ad.dx,ad.dy)
	print(bd.dx,bd.dy)
	local rot = math.atan2(ad.dy,ad.dx) - math.atan2(bd.dy,bd.dx)
	self:translate(-ad.x1,-ad.y1)
	self:translate(-ad.dx*ad.len/2,-ad.dy*ad.len/2)
	self:translate(ad.dy,-ad.dx)
	lvl:translate(-bd.x1,-bd.y1)
	lvl:translate(-bd.dx*bd.len/2,-bd.dy*bd.len/2)
	lvl:translate(bd.dy,-bd.dx)
	self:rotate(-math.pi)

	--self:translate(,-ad.len)
	--self:rotate(math.pi)

	--lvl:rotate(math.pi)
	lvl:rotate(-rot)

	local temp = {}

	for i=1,ad.i do
		table.insert(temp,{self[i][1],self[i][2],door=self[i].door,brk=self[i].brk})
	end
	--
	temp[ad.i].brk=true
	temp[ad.i].door=false
	for i,v in ipairs(lvl) do
		table.insert(temp,{v[1],v[2],door=v.door,brk=v.brk})
		if i == bd.i then
			--temp[#temp].brk = true
			temp[#temp].door = false
		end
		--table.insert(temp,{lvl[bd.i+1][1],lvl[bd.i+1][2],door=false,brk=false})
	end
	--table.insert(temp,{lvl[bd.i+1][1],lvl[bd.i+1][2],door=false,brk=false})
	temp[#temp].brk=true
	temp[#temp].door=false
	table.insert(temp,{self[ad.i][1],self[ad.i][2],door=false,brk=false})
	for i=ad.i+1,#self do
		table.insert(temp,{self[i][1],self[i][2],door=self[i].door,brk=self[i].brk})
	end
	temp[#temp].brk=true
	temp[#temp].door=false
	local corridor = modlevel.new("modlevel/corridor.lua")
	corridor:center()

	corridor:rotate(math.atan2(-ad.dy,ad.dx))
	for i,v in ipairs(corridor) do
		table.insert(temp,{v[1],v[2],door=v.door,brk=v.brk})
	end




	while #self>0 do
		table.remove(self,1)
	end
	for i,v in ipairs(temp) do
		table.insert(self,v)
	end

	--[[]
	--]]
end

function modlevel_mt.translate(self, x, y)
	for i,v in ipairs(self) do
		v[1] = v[1]+x
		v[2] = v[2]+y
	end
end

function modlevel_mt.rotate(self, a)
	local rv = {
		{math.cos(a), math.sin(a)},
		{-math.sin(a), math.cos(a)}
	}
	for i,v in ipairs(self) do
		local t = {
			v[1]*rv[1][1]+v[2]*rv[1][2],
			v[1]*rv[2][1]+v[2]*rv[2][2]
		}
		v[1]=t[1]
		v[2]=t[2]
	end
end

function modlevel_mt.draw(self,ptname)
	local last = {}
	last[1] = self[#self][1]
	last[2] = self[#self][2]
	last.door = self[#self].door
	last.brk = self[#self].brk
	for i,v in ipairs(self) do
		if last.door then
			love.graphics.setColor(255,255,0)
		else
			love.graphics.setColor(255,255,255)
		end
		if not last.brk then
			love.graphics.line(last[1]*modlevel.scale,last[2]*modlevel.scale,v[1]*modlevel.scale,v[2]*modlevel.scale)
		end
		if last.door then
			local dx = last[1]-v[1]
			local dy = last[2]-v[2]
			local len = math.sqrt(dx*dx+dy*dy)
			dx = dx/len
			dy = dy/len
			px = -dy
			py = dx
			local mx = (last[1]+v[1])/2
			local my = (last[2]+v[2])/2
			love.graphics.line(mx*modlevel.scale,my*modlevel.scale,(mx+px)*modlevel.scale,(my+py)*modlevel.scale)
			love.graphics.circle("fill",(mx+px)*modlevel.scale,(my+py)*modlevel.scale,3)
		end
		last[1] = v[1]
		last[2] = v[2]
		last.door = v.door
		last.brk = v.brk
	end
end

