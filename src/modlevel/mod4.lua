local lvl = {}

lvl.size = {7,8}

table.insert(lvl,{0,0})
table.insert(lvl,{2,0})
table.insert(lvl,{4,1})
table.insert(lvl,{6,1})
table.insert(lvl,{7,0})
table.insert(lvl,{9,0})
table.insert(lvl,{10,1})
table.insert(lvl,{11,1})


table.insert(lvl,{15,3})

table.insert(lvl,{15,5})

table.insert(lvl,{13,6})

table.insert(lvl,{11,7})
table.insert(lvl,{9,7})
table.insert(lvl,{9,6,door=true})
table.insert(lvl,{6,6})
table.insert(lvl,{6,7})
table.insert(lvl,{5,7})

table.insert(lvl,{4,7})

table.insert(lvl,{2,8})
table.insert(lvl,{0,8})
table.insert(lvl,{0,5})
table.insert(lvl,{1,5})
table.insert(lvl,{1,3})
table.insert(lvl,{0,3})
table.insert(lvl,{0,0})

for i,v in ipairs(lvl) do
	v[1]= v[1]*0.7
	v[2]= v[2]*0.7
end

return lvl