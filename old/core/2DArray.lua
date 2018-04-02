Grid = {}

function Grid:new(o)
  o = o or {width = 5, height = 5}
  setmetatable(o, self)
  self.__index = self
  if not o.data then
    o.data = {}
    for i=0,o.width*o.height-1 do
      o.data[i] = 0
    end
  end
  return o
end

-- Start at 0
function Grid:get(x, y)
  return self.data[self.width*y+x]
end

function Grid:set(x, y, v)
  self.data[self.width*y+x] = v
end

function Grid:resize(dw_left, dw_right, dh_up, dh_down)
  new = Grid:new({width = self.width+dw_left+dw_right, height = self.height+dh_up+dh_down})
  for x=-dw_left, self.width+dw_right-1 do
    for y=-dh_up, self.height+dh_down-1 do
      new:set(x+2*dw_left, y+2*dh_up, self:get(x+dw_left, y+dh_up))
    end
  end
  self = new
end


