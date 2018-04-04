require 'core/Tile'

TILES = {}

TILE_NAME_LIST = {
  "Air",
  "Marble",
  "Sandstone",
  "Wood",
  "Iron",
  "Copper",
  "Dirt",
  "Grass",
}

for i=1,#TILE_NAME_LIST do
  print(TILE_NAME_LIST[i])
  table.insert(TILES, require(string.format('core/tiles/%s', TILE_NAME_LIST[i])))
end
