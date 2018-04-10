require 'core/tiles/load'
require 'core/RotatingGrid'
require 'core/World'
require 'core/Grid'
require 'core/Tile'

metagrids = {}
function create_air()
  return Tile.new("Air", {})
end
metagrids[1] = Grid.empty(100, 100, create_air, 1, 0, 0)
-- F
metagrids[1].data[10][10] = Tile.new("Marble", {})
metagrids[1].data[11][10] = Tile.new("Marble", {})
metagrids[1].data[12][10] = Tile.new("Marble", {})
metagrids[1].data[10][11] = Tile.new("Marble", {})
metagrids[1].data[10][12] = Tile.new("Marble", {})
metagrids[1].data[11][12] = Tile.new("Marble", {})
metagrids[1].data[12][12] = Tile.new("Marble", {})
metagrids[1].data[10][13] = Tile.new("Marble", {})
metagrids[1].data[10][14] = Tile.new("Marble", {})

-- U
metagrids[1].data[14][10] = Tile.new("Marble", {})
metagrids[1].data[14][11] = Tile.new("Marble", {})
metagrids[1].data[14][12] = Tile.new("Marble", {})
metagrids[1].data[14][13] = Tile.new("Marble", {})
metagrids[1].data[15][14] = Tile.new("Marble", {})
metagrids[1].data[16][14] = Tile.new("Marble", {})
metagrids[1].data[17][10] = Tile.new("Marble", {})
metagrids[1].data[17][11] = Tile.new("Marble", {})
metagrids[1].data[17][12] = Tile.new("Marble", {})
metagrids[1].data[17][13] = Tile.new("Marble", {})

-- C
metagrids[1].data[19][10] = Tile.new("Marble", {})
metagrids[1].data[20][10] = Tile.new("Marble", {})
metagrids[1].data[21][10] = Tile.new("Marble", {})
metagrids[1].data[19][10] = Tile.new("Marble", {})
metagrids[1].data[19][11] = Tile.new("Marble", {})
metagrids[1].data[19][12] = Tile.new("Marble", {})
metagrids[1].data[19][13] = Tile.new("Marble", {})
metagrids[1].data[19][14] = Tile.new("Marble", {})
metagrids[1].data[20][14] = Tile.new("Marble", {})
metagrids[1].data[21][14] = Tile.new("Marble", {})

-- K
metagrids[1].data[25][10] = Tile.new("Marble", {})
metagrids[1].data[23][10] = Tile.new("Marble", {})
metagrids[1].data[25][11] = Tile.new("Marble", {})
metagrids[1].data[23][11] = Tile.new("Marble", {})
metagrids[1].data[23][12] = Tile.new("Marble", {})
metagrids[1].data[24][12] = Tile.new("Marble", {})
metagrids[1].data[23][13] = Tile.new("Marble", {})
metagrids[1].data[25][13] = Tile.new("Marble", {})
metagrids[1].data[23][14] = Tile.new("Marble", {})
metagrids[1].data[25][14] = Tile.new("Marble", {})
grids = {}
grids[1] = RotatingGrid.new(metagrids, 0, 0, math.pi/8)

w = World.new(grids)
return w
