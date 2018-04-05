Grid = {}
Grid.__index = Grid

-- Column Major (Grid.data[col][row]

function Grid.fromData(data, scale, originx, originy, ...)
  local self = {}
  setmetatable(self, Grid)
  self.data = data
  -- The origin is in parent coords
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

-- Turns coordinates from the grid data space to the parent space
function Grid:gridToParent(x, y)
  return x*self.scale+self.x, y*self.scale+self.y
end

-- Turns coordinates from the grid data space to the parent space
function Grid:parentToGrid(x, y)
  return math.floor(x/self.scale)+self.x, math.floor(y/self.scale)+self.y
end

-- Parent space
function Grid:parent_get(self, x, y)
  if not self.contains(x,y) then
    return nil
  else
    local rx, ry = self:parentToGrid(x, y)
    return self.data[rx][ry]
  end
end

-- Parent space
function Grid:contains(x, y)
  local lx, ly = self:parentToGrid(x,y)
  return (lx >= 1 and ly >= 1) and (lx <= self.width*self.scale and ly <= self.height*self.scale)
end

-- Array manipulation 
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
