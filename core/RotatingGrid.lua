require 'core/MetaGrid'

RotatingGrid = MetaGrid.new({}, 0, 0)
RotatingGrid.__index = RotatingGrid

function RotatingGrid.new(grids, x, y, ...)
  local self = MetaGrid.new(grids, x, y)
  setmetatable(self, RotatingGrid)
  self.angle = ...
  self.angle = self.angle or 0
  self.x = x
  self.y = y
  self.grids = grids
  self:update_center()
  return self
end

-- Turns coordinates from the grid data space to the parent space
function RotatingGrid:gridToParent(x, y)
  local cx = x - self.cx
  local cy = y - self.cy
  -- Rotate relative coordinates by self.angle
  local theta = math.atan2(cy, cx)
  local mag = math.sqrt(cx*cx + cy*cy)
  -- Add rotated coordinates to the grid center and grid origin
  return mag*math.cos(theta+self.angle) + self.cx + self.x, mag*math.sin(theta+self.angle) + self.cy + self.y
end

function RotatingGrid:parentToGrid(x, y)
  local cx = x - self.x - self.cx
  local cy = y - self.y - self.cy
  -- Rotate relative coordinates by self.angle
  local theta = math.atan2(cy, cx)
  local mag = math.sqrt(cx*cx + cy*cy)
  -- Add rotated coordinates to the grid center and grid origin
  return mag*math.cos(theta-self.angle) + self.cx + self.x, mag*math.sin(theta-self.angle) + self.cy + self.y
end

-- The center of the grid in data space
function RotatingGrid:update_center()
  local sum_x, sum_y, n = 0, 0, 0
  local density = 0
  for i=1,#self.grids do
    local grid = self.grids[i]
    n = n + grid.width + grid.height
    for x=0,grid.width-1 do
      for y=0,grid.height-1 do
        density = grid.data[x+1][y+1].density or 0
        sum_x = sum_x + (x+grid.x)*density
        sum_y = sum_y + (y+grid.y)*density
      end
    end
  end
  self.cx = math.floor(sum_x/n+0.5)
  self.cy = math.floor(sum_y/n+0.5)
  return self.cx, self.cy
end

function RotatingGrid:add_grid(grid)
  MetaGrid.add_grid(self, grid)
  self:update_center()
end
