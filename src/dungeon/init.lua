local dungeon_mt = {}
local dunghires_mt = setmetatable({},{__index=dungeon_mt})

wallim = love.graphics.newImage("images/wall.png")
floorim = love.graphics.newImage("images/floor.png")

dungeon = {}

function dungeon.new(xsize,ysize)
  local self = setmetatable({},{__index=dungeon_mt})
  self.tiles = {}
  self.offsets = {}
  self.xsize = xsize or 15
  self.ysize = ysize or 15
  for i=1,self.xsize do
    self.tiles[i]={}
    self.offsets[i]={}
    for j=1,self.ysize do
      self.tiles[i][j] = "wall"
      self.offsets[i][j] = math.random(0,0)
    end
  end
  return self
end

function dungeon.newMaze(xsize,ysize)
    local d = dungeon.new(xsize,ysize)
    d:dig()
    return d
end

function dungeon.newDust(xsize,ysize)
    local d = dungeon.new(xsize,ysize)
    d:fill("wall")
    d:crap(0.4,"wall")
    for i=1,6 do
      d:randroom(3,6,"rect")
    end
    for i=1,6 do
      --d:dig()
    end
    --d:replace("damage","wall")
    --d:crap(0.1,"wall")
    for i=1,6 do
      --d:cdig()
    end
    --d:crap(1,"wall")
    --d:replace("flal","wall")
    --d:passage()
    --d:crap(1,"damage","wall")
    --d:crap(0.5,"damage","wall")

    --d:foreveralone("wall", "room")

    for i=1,10 do
      d:foreveralone("corridor", "wall",7)
    end

    for i=1,10 do
      d:foreveralone("wall", "room",7)
    end

    --d:rect(1,1,1,ysize,"wall")
    --d:rect(1,1,xsize,1,"wall")
    --d:rect(xsize,1,xsize,ysize,"wall")
    --d:rect(1,ysize,ysize,xsize,"wall")
    return d
end


function dungeon.newMade(xsize,ysize)
    local d = dungeon.new(xsize,ysize)
    d:fill("wall")
    d:crap(0.4,"wall")
    for i=1,1 do
      d:dig(math.floor(xsize/2),math.floor(ysize/2))
      d:dig(math.floor(xsize/2)+1,math.floor(ysize/2)+1)
    end
    for i=1,6 do
      d:randroom(2,5,"rect")
    end
    d:replace("damage","wall")
    --d:crap(0.1,"wall")
    for i=1,6 do
      --d:cdig()
    end
    --d:crap(1,"wall")
    --d:replace("flal","wall")
    --d:passage()
    --d:crap(1,"damage","wall")
    --d:crap(0.5,"damage","wall")

    --d:foreveralone("wall", "room")

    for i=1,10 do
      d:foreveralone("corridor", "wall",7)
    end

    for i=1,10 do
      d:foreveralone("wall", "room",7)
    end

    d:rect(1,1,1,ysize,"wall")
    d:rect(1,1,xsize,1,"wall")
    d:rect(xsize,1,xsize,ysize,"wall")
    d:rect(1,ysize,ysize,xsize,"wall")
    return d
end


function dungeon_mt.fill(self, mat)
  for i=1,self.xsize do
    for j=1,self.ysize do
      self.tiles[i][j] = mat or "wall"
    end
  end
end

function dungeon_mt.foreveralone(self, mat, rep, max)
  max = max or 8
  for i=1,self.xsize do
    for j=1,self.ysize do
      if self:get(i,j)==mat then
        local loneliness=0
        if self:get(i+1,j)~=mat then
          loneliness = loneliness+1
        end
        if self:get(i,j+1)~=mat then
          loneliness = loneliness + 1
        end
        if self:get(i-1,j)~=mat then
          loneliness = loneliness + 1
        end
        if self:get(i,j-1)~=mat then
          loneliness = loneliness + 1
        end
        if self:get(i+1,j+1)~=mat then
          loneliness = loneliness + 1
        end
        if self:get(i-1,j+1)~=mat then
          loneliness = loneliness + 1
        end
        if self:get(i+1,j-1)~=mat then
          loneliness = loneliness + 1
        end
        if self:get(i-1,j-1)~=mat then
          loneliness = loneliness + 1
        end
        if loneliness>= max then
          self:set(i,j,rep)
        end
      end
    end
  end
end


function dungeon_mt.crap(self,prob,mat1,mat2)
  for i=1,self.xsize do
    for j=1,self.ysize do
      if math.random()<prob and self:get(i,j)==mat1 then
        --print("Found "..mat1..", placing "..(mat2 or "damage"))
        self:set(i,j,(mat2 or "damage"))
      end
    end
  end
end

function dungeon_mt.replace(self,mat1,mat2)
  for i=1,self.xsize do
    for j=1,self.ysize do
      if self.tiles[i][j]==mat1 then
        --print("Found "..mat1..", placing "..mat2)
        self.tiles[i][j] = mat2
      end
    end
  end
end

function dungeon.walkable(mat)
  return (mat=="room" or mat=="cave" or mat=="corridor")
end

function dungeon_mt.passage(self)
  for i=1,self.xsize do
    for j=1,self.ysize do
      if self:get(i,j)=="damage" then
        local up = dungeon.walkable(self:get(i,j-1))
        local down = dungeon.walkable(self:get(i,j+1))
        local left = dungeon.walkable(self:get(i-1,j))
        local right = dungeon.walkable(self:get(i+1,j))
        if (up == down) and (left == right ) and (left~=down) then

        else
          self:set(i,j,"wall")
        end

      end
    end
  end
end

function dungeon_mt.solid(self, x, y, val, diag)
  if x>1 and x<self.xsize and y>1 and y<self.ysize then
    local t = self.tiles[x][y]
    s = 0
    if t==self.tiles[x+1][y] then
      s=s+1
    end
    if t==self.tiles[x-1][y] then
      s=s+1
    end
    if t==self.tiles[x][y+1] then
      s=s+1
    end
    if t==self.tiles[x][y-1] then
      s=s+1
    end
    if not diag then
      return s>=val
    else
      if t==self.tiles[x+1][y+1] then
        s=s+1
      end
      if t==self.tiles[x+1][y-1] then
        s=s+1
      end
      if t==self.tiles[x-1][y+1] then
        s=s+1
      end
      if t==self.tiles[x-1][y-1] then
        s=s+1
      end
      return s>=val
    end
  else
    return false
  end
end

function dungeon_mt.dig(self,x,y,mat)
  local x = x or math.random(1,self.xsize)
  local y = y or math.random(1,self.ysize)
  if self:get(x,y)=="wall" then
    self:set(x,y,"corridor")
  end
  local d = {"up", "down", "left", "right"}
  local mat = mat or "wall"
  for i=1,4 do
    local one, two = math.random(1,4),math.random(1,4)
    d[one],d[two] = d[two],d[one]
  end
  for i,v in ipairs(d) do
    if v=="up" then
      if y-2 >= 1 and self.tiles[x] and self.tiles[x][y-2]==mat then
        self:set(x,y-1,"corridor")
        self:set(x,y-2,"corridor")
        self:dig(x,y-2)
      end
    end
    if v=="down" then
      if y+2 <= self.ysize and self.tiles[x] and self.tiles[x][y+2]==mat then
        self:set(x,y+1,"corridor")
        self:set(x,y+2,"corridor")
        self:dig(x,y+2)
      end
    end
    if v=="left" then
      if x-2 >= 1 and self.tiles[x-2][y]==mat then
        self:set(x-1,y,"corridor")
        self:set(x-2,y,"corridor")
        self:dig(x-2,y)
      end
    end
    if v=="right" then
      if x+2 <= self.xsize and self.tiles[x+2][y]==mat then
        self:set(x+1,y,"corridor")
        self:set(x+2,y,"corridor")
        self:dig(x+2,y)
      end
    end
  end
end

function dungeon_mt.cdig(self,x,y,mat)
  local x = x or math.floor(math.random(1,self.xsize)/2)*2
  local y = y or math.floor(math.random(1,self.ysize)/2)*2
  if self:get(x,y)=="wall" then
    self:set(x,y,"cave")
  end
  local d = {"up", "down", "left", "right"}
  local digval = 6
  local diag = true
  local mat = mat or "wall"
  for i=1,4 do
    local one, two = math.random(1,4),math.random(1,4)
    d[one],d[two] = d[two],d[one]
  end
  for i,v in ipairs(d) do
    if v=="up" then
      if y-2 >= 1 and self.tiles[x] and self.tiles[x][y-1]==mat and self:solid(x,y-1,digval,diag) then
        self:cdig(x,y-1)
      end
    end
    if v=="down" then
      if y+2 <= self.ysize and self.tiles[x] and self.tiles[x][y+1]==mat and self:solid(x,y+1,digval,diag) then
        self:cdig(x,y+1)
      end
    end
    if v=="left" then
      if x-2 >= 1 and self.tiles[x-1][y]==mat and self:solid(x-1,y,digval,diag) then
        self:cdig(x-1,y)
      end
    end
    if v=="right" then
      if x+2 <= self.xsize and self.tiles[x+1][y]==mat and self:solid(x+1,y,digval,diag) then
        self:cdig(x+1,y)
      end
    end
  end
end

function dungeon_mt.echo(self)
  local s = ""
  for i=1,self.xsize do
    for j=1,self.ysize do
      if self:get(i,j)=="wall" then
        s = s.."#"
      elseif self:get(i,j)=="damage" then
        s = s.."%"
      else
        s = s.." "
      end
    end
    s = s.."\n"
  end
  print(s)
end

function dist(x1,y1,x2,y2)
  local dx = x2-x1
  local dy = y2-y1
  return math.sqrt(dx*dx+dy*dy)
end

function dungeon_mt.ray(self,x1,y1,x2,y2)
  local i,j = x1,y1
  local function step(xone,yone,xtwo,ytwo)
    local dx = xtwo-xone
    local dy = ytwo-yone
    if math.abs(dx) > math.abs(dy) then
      if dx>0 then
        return xone+1, yone
      else
        return xone-1, yone
      end
    elseif math.abs(dx) < math.abs(dy) then
      if dy>0 then
        return xone, yone+1
      else
        return xone, yone-1
      end
    else
      local mx,my = 0,0
      if dx>0 then
        mx = 1
      else
        mx = -1
      end
      if dy>0 then
        my = 1
      else
        my = -1
      end
      return xone+mx, yone+my
    end
  end
  while i~=x2 or j~=y2 do
    if self:get(i,j)=="wall" then
      return false
    end
    i,j = step(i,j,x2,y2)
  end
  return true
end

function dungeon_mt.shine(self,x,y,range,f)
  local s = ""
  local range = range or 5
  for i=1,self.xsize do
    for j=1,self.ysize do
      if self:get(i,j)=="wall" then
        if dist(x,y,i,j)<range and self:ray(x,y,i,j) then
          if f then
            f(i,j,self:get(i,j))
          else
            s = s.."#"
          end
        else
          s = s.."."
        end
      elseif self:get(i,j)=="damage" then
        if dist(x,y,i,j)<range and self:ray(x,y,i,j) then
          if f then
            f(i,j,self:get(i,j))
          else
            s = s.."#"
          end
        else
          s = s.."."
        end
      else
        if dist(x,y,i,j)<range and self:ray(x,y,i,j) then
          if f then
            f(i,j,self:get(i,j))
          else
            s = s.."#"
          end
        else
          s = s.."."
        end
      end
    end
    s = s.."\n"
  end
  if not f then print(s) end
end

function dungeon_mt.rect(self,x1,y1,x2,y2,mat)
  --print(x1,y1,x2,y2)
  for i=x1,x2 do
    for j=y1,y2 do
      self:set(i,j,mat)
    end
  end
end

function dungeon_mt.circle(self,x,y,r,mat)
  --print(x,y,r,mat)
  for i=-r,r do
    for j=-r,r do
      local dx = i
      local dy = j
      if math.sqrt(dx*dx+dy*dy)<r then
        if x+i>1 and x+i<self.xsize and y+j>1 and y+j<self.ysize then
          self:set(x+i,y+j,mat)
        end
      end
    end
  end
end

function dungeon_mt.randroom(self,minsize,maxsize,roomstyle)
  local x = math.floor(math.random(1,self.xsize)/2)*2
  local y = math.floor(math.random(1,self.ysize)/2)*2
  local sw = math.random()>0.5
  if not roomstyle or roomstyle=="rect" or (roomstyle=="both" and sw) then
    local sizex = math.floor(math.random(minsize,maxsize)/2)*2
    local sizey = math.floor(math.random(minsize,maxsize)/2)*2
    self:rect(x,y,x+sizex,y+sizey,"room")
  elseif roomstyle=="circle" or (roomstyle=="both" and not sw) then
    local rad = math.random(minsize,maxsize)
    self:circle(x,y,rad,"room")
  end
end

function dungeon_mt.get(self,x,y)
  local x = math.floor(x)
  local y = math.floor(y)
  if x>=1 and x<=self.xsize and y>=1 and y<=self.ysize then
    return self.tiles[x][y]
  else
    return "wall"
  end
end

function dungeon_mt.getoff(self,x,y)
  if x>=1 and x<=self.xsize and y>=1 and y<=self.ysize then
    return self.offsets[x][y]
  else
    return 0
  end
end

function dungeon_mt.set(self,x,y,mat)
  if x>=1 and x<=self.xsize and y>=1 and y<=self.ysize then
    self.tiles[x][y] = mat
  end
end

--pcalls = 0

function dungeon_mt.explore(self,x,y,val)
  --pcalls = pcalls+1
  --print(pcalls)
  local x=x or 10
  local y=y or 10
  local val = val or 0
  self:set(x,y,val)
  if val < 100 then
    --print(val)
    local d = {"up", "down", "left", "right"}
    for i=1,4 do
      local one, two = math.random(1,4),math.random(1,4)
      d[one],d[two] = d[two],d[one]
    end
    for i,v in ipairs(d) do
      if v=="up" then
        local t = self:get(x,y-1)
        if (type(t)=="number" and t>val) or t=="room" or t=="corridor" then
          self:explore(x,y-1,val+1)
        elseif t=="damage" then
          --self:explore(x,y-1,val+1)
        end  
      end
      if v=="down" then
        local t = self:get(x,y+1)
        if (type(t)=="number" and t>val) or t=="room" or t=="corridor" then
          self:explore(x,y+1,val+1)
        elseif t=="damage" then
          --self:explore(x,y+1,val+1)
        end
      end
      if v=="left" then
        local t = self:get(x-1,y)
        if (type(t)=="number" and t>val) or t=="room" or t=="corridor" then
          self:explore(x-1,y,val+1)
        elseif t=="damage" then
          --self:explore(x-1,y,val+1)
        end
      end
      if v=="right" then
        local t = self:get(x+1,y)
        if (type(t)=="number" and t>val) or t=="room" or t=="corridor" then
          self:explore(x+1,y,val+1)
        elseif t=="damage" then
          --self:explore(x+1,y,val+1)
        end
      end
    end
  end
end

-- Lovely functions 

if love then
  function dungeon_mt.draw(self,x1,y1,x2,y2,sc)
    local scale = sc or (scale or 12)
    local x1 = x1 or 1
    local x2 = x2 or #self.tiles
    local y1 = y1 or 1
    local y2 = y2 or #self.tiles[1]
    for i=x1,x2 do
      for j=y1,y2 do
        if not dungeon.walkable(self:get(i,j)) then
          love.graphics.rectangle("fill",i*scale,j*scale,scale-1,scale-1)
        end
      end
    end
  end

  function dungeon_mt.pretty(self, x, y, d, scalex, scaley,light)
    scalex = sc or (scalex or 12)
    scaley = scaley or scalex
    --love.graphics.setColor(64,64,64)
    if not light then
      love.graphics.setColor(255,255,255)
      for i,t in ipairs(self.tiles) do
        for j,mat in ipairs(t) do
          if mat=="wall" then
            love.graphics.draw(wallim,i*scalex,j*scaley-8)
          else
            love.graphics.draw(floorim,i*scalex,j*scaley)
          end
        end
      end
    end
    --[[]]
    if light then
      love.graphics.setColor(255,255,255)
      self:shine(math.floor(x),math.floor(y),d,function(i,j,mat)
        if mat=="wall" then
          love.graphics.draw(wallim,i*scalex,j*scaley-8)
        else
          love.graphics.draw(floorim,i*scalex,j*scaley)
        end
        --love.graphics.rectangle("fill",i*scalex,j*scaley,scalex-1,scaley-1)
      end)
    end
    --]]
  end

end