useful = {}

local last = 0

function useful.print(text, halign, valign, hoffset, voffset, scale)
	halign = halign or "left"
	valign = valign or "top"
	hoffset = hoffset or 0
	voffset = voffset or 0
	scale = scale or 1
	local width = font:getWidth(text)
	local height = font:getHeight()
	local x = hoffset
	local y = voffset
	if halign == "center" then
		x = (love.graphics.getWidth()/(2*scale)+hoffset-width/2)
	elseif halign =="right" then
		x = (hoffset-width)
	elseif halign=="last" then
		x = last
	end
	if valign == "center" then
		y = (love.graphics.getHeight()/(2*scale)+voffset-height/2)
	elseif valign =="bottom" then
		y = (love.graphics.getHeight()/scale)+(voffset)
	end
	last = x
	love.graphics.print(text,x,y)
end