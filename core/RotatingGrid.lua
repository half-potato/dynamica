require 'core/tiles/MetaGrid'

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
  return self
end

function RotatingGrid:get_rel_xy(self, x, y)
  local cx = x - self.x
  local cy = y - self.y
  local theta = math.atan2(cy, cx)
  local mag = sqrt(cx**2 + cy**2)
  return mag*cos(theta+self.angle) + self.x, mag*sin(theta+self.angle) + self.y
end

function RotatingGrid:update_center(self)
  local sum_x, sum_y, n = 0, 0, 0
  local density = 0
  for i=1,#self.grids do
    local grid = self.grids[i]
    n = n + grid.width + grid.height
    for x=0,grid.width-1 do
      for y=0,grid.height-1 do
        density = grid[x][y].density or 0
        sum_x = sum_x + (x+grid.x)*density
        sum_y = sum_y + (y+grid.y)*density
      end
    end
  end
  self.x = math.floor(sum_x/n+0.5)
  self.y = math.floor(sum_y/n+0.5)
  return self.x, self.y
end

function RotatingGrid:add_grid(self, grid)
  MetaGrid.add_grid(self, grid)
  self:update_center()
end
