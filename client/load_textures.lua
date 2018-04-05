require 'core/tiles/load'

TILE_TEXTURES = {}

for i=1,#TILES do
  TILE_TEXTURES[TILES[i].name] = love.graphics.newImage("assets/"..TILES[i].texture)
end
