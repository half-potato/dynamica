require 'core/tiles/load'

-- Load tile textures + spritesheet
SPRITESHEET = love.graphics.newImage("assets/spritesheet.png")
SPRITESHEET:setFilter("nearest", "nearest")
TILE_TEXTURES = {}
TILE_QUADS = {}
TILE_H = 16
TILE_W = 16
SPRITESHEET_H = SPRITESHEET:getHeight()
SPRITESHEET_W = SPRITESHEET:getWidth()
SPRITESHEET_IW = SPRITESHEET_W / TILE_W

for i=1,#TILES do
  local tile = TILES[i]
  print("loaded texture for "..tile.name)
  if tile.texture then
    TILE_TEXTURES[tile.name] = love.graphics.newImage("assets/"..tile.texture)
    TILE_TEXTURES[tile.name]:setFilter("nearest", "nearest")
  else
    local x = tile.spritesheet_index % SPRITESHEET_IW
    local y = math.floor(tile.spritesheet_index / SPRITESHEET_IW)
    TILE_QUADS[tile.name] = love.graphics.newQuad(x*TILE_W, y*TILE_H, TILE_W, TILE_H, SPRITESHEET_W, SPRITESHEET_H)
  end
end

-- Load entity textures
--ENTITY
