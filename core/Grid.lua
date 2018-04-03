Grid = {}
Grid.__index = Grid

-- Column Major (Grid.data[col][row]

function Grid.fromData(data, scale, originx, originy, ...)
  local self = {}
  setmetatable(self, Grid)
  self.data = data
  self.x = originx
  self.y = originy
  self.scale = scale
  self.width, self.height = ...
  if not (self.width and self.height) then
    -- Count width and height
    self.width = #data
    self.height = #data[0]
  end
  return self
end

function Grid.empty(width, height, zero_fn, scale, originx, originy)
  local zeroArr = {}
  for i=1,width do
    zeroArr[i] = {}
    for j=1,height do
      zeroArr[i][j] = zero_fn()
    end
  end
  return Grid.fromData(zeroArr, scale, originx, originy, width, height)
end

function Grid:rel_get(self, x, y)
  if not self.contains(x,y) then
    return nil
  else
    return self.data[math.ceil((x-self.x)/scale)][math.ceil((y-self.y)/scale)]
  end
end

function Grid:contains(self, x, y)
  local lx, ly = self:rel_get(x,y)
  return (lx >= 1 and ly >= 1) and (lx <= self.width and ly <= self.height)
end

function Grid:insert_row(self, i, row)
  self.data.insert(i, row)
  table.insert(self.data, i, row)
  self.width = self.width + 1
end

function Grid:insert_col(self, j, col)
  for i=1,width do
    table.insert(self.data[i], j, col)
  end
  self.height = self.height + 1
end

function Grid:remove_row(self, i)
  table.remove(self.data, i)
  self.width = self.width - 1
end

function Grid:remove_col(self, j)
  for i=1,width do
    table.remove(self.data[i], j)
  end
  self.height = self.height - 1
end

function isOccupied(self)
  for i=1,width do
    for j=1,height do
      if self.data[i][j].isOccupied() then
        return true
      end
    end
  end
  return false
end
