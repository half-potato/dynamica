require 'core/tiles/load'
require 'core/RotatingGrid'
require 'core/Grid'
require 'core/Tile'
require 'client/load_textures'
require 'core/World'
require 'client/WorldRenderer'
require 'client/Hotbar'

local world = {}
local isDrawing = false

tile_selection = {
  Tile.new("Air", {}),
  Tile.new("Marble", {}),
  Tile.new("Sandstone", {}),
  Tile.new("Wood", {}),
  Tile.new("Iron", {}),
  Tile.new("Copper", {}),
  Tile.new("Dirt", {}),
  Tile.new("Grass", {}),
}

game = {}
scale = 16

function game:init()
  world = require 'core/worldgen/Test1'
  setmetatable(world, World)
  self.hotbar = Hotbar.new(10, 0, tile_selection)
end

function game:draw()
  if world then
    world:draw(scale, 0, 0)
  end
  self.hotbar:draw()
end

function game:update(dt)
  self.hotbar:update(dt)
  if isDrawing then
    world:set(love.mouse.getX()/scale, love.mouse.getY()/scale, self.hotbar:getSelected())
  end
end

function game:mousepressed()
  isDrawing = true
  world:set(love.mouse.getX()/scale, love.mouse.getY()/scale, self.hotbar:getSelected())
end

function game:mousereleased()
  isDrawing = false
end
