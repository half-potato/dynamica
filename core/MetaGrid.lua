MetaGrid = {}
MetaGrid.__index = MetaGrid

function MetaGrid.new(grids, originx, originy)
  local self = {}
  setmetatable(self, MetaGrid)
  self.x = originx
  self.y = originy
  self.grids = grids
  return self
end

function MetaGrid:get_rel_xy(self, x, y)
  return x-self.x, y-self.y
end

-- Optional arguments: ignored_grids_ind, the indicies of grids to ignore when looking
function MetaGrid:grids_at(self, x, y, ...)
  local out = {}
  local ignored_grids_ind = ... or {}
  for i=1,#self.grids do
    -- Check if index is in ignore list
    local ignore = false
    for j=1,#ignored_grids_ind do
      if i=ignored_grids_ind[j] then
        ignore = true
      end
    end
    -- Add to output if point is contained in grid
    if not ignore and self.grids[i]:contains(x,y) then
      table.insert(out, self.grids[i])
    end
  end
  return out
end

-- Optional arguments: ignored_grids_ind, the indicies of grids to ignore when looking
function MetaGrid:tiles_at(self, x, y, ...)
  local out = {}
  local grids = self:grids_at(x,y,...)
  for i=1,#grids do
    table.insert(out, grids[i].rel_get(x,y))
  end
  return out
end

-- Optional arguments: 
-- ignored_grids_ind, the indicies of grids to ignore when looking
-- dx, dy, the offset of the grid being checked
function MetaGrid:check_overlap(self, grid, ...)
  ignored_grids_ind, dx, dy = ...
  for x=1,grid.width do
    for y=1,grid.height do
      if grid.data[x][y].isOccupied() then
        -- Get x, y within metagrid
        local tiles = self:tiles_at(x+grid.x+dx, y+grid.y+dy, ignored_grids_ind)
        for i=1,#tiles do
          if tiles[i].isOccupied() then
            return true
          end
        end
      end
    end
  end
  return false
end

function MetaGrid:move_grid(self, g_index, dx, dy)
  if nto self:check_overlap(self.grids[g_index], {g_index}, dx, dy) then
    self.grids[g_index].x = dx + self.grids[g_index].x
    self.grids[g_index].y = dy + self.grids[g_index].y
    return true
  end
  return false
end

function MetaGrid:add_grid(self, grid)
  if not self.check_overlap(grid) then
    table.insert(self.grids, grid)
    return true
  end
  return false
end

function MetaGrid:remove_grid(self, g_index)
  return table.remove(self.grid, g_index)
end
