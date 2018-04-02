MultiArray = {}
MultiArray.__index = MultiArray

function MultiArray:new(o)
  local o = o or {width = 5, height = 5}
  if not o.data then
    o.data = {}
    for i=1,o.width*o.height do
      o.data[i] = 0
    end
  end
  o = setmetatable(o, MultiArray)
  --self.__index = self
  return o
end

-- Start at 0
function MultiArray:get(x, y)
  return self.data[self.width*y+x+1]
end

-- Start at 0
function MultiArray:set(x, y, v)
  self.data[self.width*y+x+1] = v
end

function MultiArray:__tostring()
  s = ""
  for j = 0,self.height-1 do
    for i = 0,self.width-1 do
      s = s .. (tostring(self:get(i,j)) .. ", ")
    end
    s = s .. "\n"
  end
  return s
end

-- positive values denoting how much to shrink each dimension
function MultiArray:shrink(dw_left, dw_right, dh_up, dh_down)
  local new = MultiArray:new({width = self.width-dw_left-dw_right, height = self.height-dh_up-dh_down})
  for x=dw_left, self.width-dw_right-1 do
    for y=dh_up, self.height-dh_down-1 do
      new:set(x-dw_left, y-dh_up, self:get(x, y))
    end
  end
  return new
end

-- positive values denoting how much to grow each dimension
function MultiArray:grow(dw_left, dw_right, dh_up, dh_down)
  local new = MultiArray:new({width = self.width+dw_left+dw_right, height = self.height+dh_up+dh_down})
  print(new)
  print(dw_left)
  for x=dw_left, self.width+dw_left-1 do
    for y=dh_up, self.height+dh_up-1 do
      new:set(x, y, self:get(x-dw_left, y-dh_up))
    end
  end
  return new
end

