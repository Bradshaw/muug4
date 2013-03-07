local seq = {}

seq.current = 0

seq.pages = {}

function seq.new(page, n)
	if n then
		table.insert(seq.pages, n, page)
	else
		table.insert(seq.pages, page)
	end
end

function seq.next()
	seq.current = math.max(1, math.min(#seq.pages, seq.current+1))
	gstate.switch(seq.pages[seq.current], seq.current)
end

function seq.previous()
	seq.current = math.max(1, math.min(#seq.pages, seq.current-1))
	gstate.switch(seq.pages[seq.current], seq.current)
end

function seq.reload()
	gstate.switch(seq.pages[seq.current], seq.current)
end








return seq