require 'core/RotatingGrid'
require 'client/load_textures'

function RotatingGrid:draw(scale, screenox, screenoy)
  for i=1,#self.grids do
    local grid = self.grids[i]
    local sprites = love.graphics.newSpriteBatch(SPRITESHEET, grid.width*grid.height)
    for x=1,grid.width do
      for y=1,grid.height do
        --local cx, cy = self:gridToWorld(grid.scale*(x+grid.x-1), grid.scale*(y+grid.x-1))
        local cx, cy = self:gridToParent(grid:gridToParent(x, y))
        local rx = scale*(cx + self.x)
        local ry = scale*(cy + self.y)
        local name = grid.data[x][y].name
        local tex = TILE_TEXTURES[name]
        if tex then
          love.graphics.draw(tex, rx, ry, self.angle, 1/tex:getWidth()*scale, 1/tex:getHeight()*scale)
        else
          local q = TILE_QUADS[name]
          sprites:add(q, rx, ry, self.angle, 1/TILE_W*scale, 1/TILE_H*scale)
        end
      end
    end
    love.graphics.draw(sprites, screenox, screenoy, 0, 1, 1)
  end
end
