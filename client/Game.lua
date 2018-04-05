require 'core/tiles/load'
require 'core/RotatingGrid'
require 'core/EntityManager'
require 'core/Grid'
require 'core/Tile'
require 'client/load_textures'
require 'core/World'
require 'client/WorldRenderer'
require 'client/MainPlayer'
require 'client/KeyboardInterface'
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
  self.world = require 'core/worldgen/Test1'
  setmetatable(world, World)
  self.hotbar = Hotbar.new(10, 0, tile_selection)
  love.graphics.setDefaultFilter("nearest", "nearest", 1)
  local interface = KeyboardInterface.new()
  local player = MainPlayer.new("Player", 100, 100, nil, vector(100, 100), 50000, 10, 5, 20, interface)
  self.entityManager = EntityManager.new({player}, world)
end

function game:draw()
  self.world:draw(scale, 0, 0)
  self.hotbar:draw()
end

function game:update(dt)
  self.hotbar:update(dt)
  if isDrawing then
    self.world:set(love.mouse.getX()/scale, love.mouse.getY()/scale, self.hotbar:getSelected())
  end
  self.entityManager:update(dt)
end

function game:mousepressed()
  isDrawing = true
  world:set(love.mouse.getX()/scale, love.mouse.getY()/scale, self.hotbar:getSelected())
end

function game:mousereleased()
  isDrawing = false
end
