Grid = {}
Grid.__index = Grid

function Grid:new(o)
  o = o or {width = 5, height = 5, center = {x = 0, y = 0}}
  setmetatable(o, self)
  self.__index = self
  if not o.data then
    o.data = {}
    for i=1,o.width*o.height do
      o.data[i] = 0
    end
  end
  return o
end
