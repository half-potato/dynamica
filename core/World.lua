World = {}
World.__index = World

function World.new(grids)
  local self = {}
  setmetatable(self, World)
  self.grids = grids
  return self
end

function World:get(x, y)
  local out = {}
  for i=1,#self.grids do
    local g_out = self.grids[i]:get(x, y)
    if #g_out ~= 0 then
      out = table.concat(out, g_out)
    end
  end
  return out
end

function World:set(x, y, val)
  for i=1,#self.grids do
    if self.grids[i]:set(x, y, val) then
      return true
    end
  end
  return false
end
