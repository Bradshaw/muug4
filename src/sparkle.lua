sparkle = {}

function sparkle.new(image, n, rate, x1, y1, x2, y2, d, sp, l, rd, rs, rl, snake, red, green, blue)
	s = {}
	s.emit = true
	s.red = red or 255
	s.green = green or 255
	s.blue = blue or 255
	s.emitted = {}
	s.image = image
	s.n = n
	s.rate = rate
	s.elap = 0
	s.x1 = x1
	s.x2 = x2 or x1
	s.y1 = y1
	s.y2 = y2 or y1
	s.d = d or math.random()*math.pi()*2
	s.sp = sp or 1
	s.l = l or 100
	s.rd = rd or 0
	s.rs = rs or 0
	s.rl = rl or 0
	s.snake = snake or {amp = 0, speed = 0}
	s.rt = 0
	return s
end

function sparkle.update(s, dt)
	s.elap = s.elap + (1/s.rate)*dt
	s.rt = s.rt + dt
	while s.emit and s.elap > 0 and #s.emitted < s.n do
		local part = {}
		part.off = math.random()*500
		part.x=math.random(s.x1,s.x2)
		part.y=math.random(s.y1,s.y2)
		part.s=s.sp+math.random()*s.rs
		part.d=s.d+math.random()*s.rd
		part.l=s.l+math.random()*s.rl
		table.insert(s.emitted, part)
		s.elap = s.elap - s.rate
	end
	for i=1,#s.emitted do
		local dir = s.emitted[i].d + s.snake.amp * math.cos(s.rt*s.snake.speed+s.emitted[i].off)
		s.emitted[i].x = s.emitted[i].x + s.emitted[i].s * math.cos(dir) * dt
		s.emitted[i].y = s.emitted[i].y + s.emitted[i].s * math.sin(dir) * dt
		s.emitted[i].l = s.emitted[i].l-1*dt
		if s.emit and s.emitted[i].l < 0 then
			s.emitted[i].x=math.random(s.x1,s.x2)
			s.emitted[i].y=math.random(s.y1,s.y2)
			s.emitted[i].s=s.sp+math.random()*s.rs
			s.emitted[i].d=s.d+math.random()*s.rd
			s.emitted[i].l=s.l+math.random()*s.rl
		end

	end
end

function sparkle.draw(s)
	local palpha = 0
	for i=1,#s.emitted do
		palpha = 255*(s.emitted[i].l/s.l)
		if palpha > 255 then palpha = 255 end
		love.graphics.setColor(s.red,s.green,s.blue,palpha)
		love.graphics.draw(s.image, math.floor(s.emitted[i].x), math.floor(s.emitted[i].y))
	end
end


