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
Camera = require 'lib/hump.camera'

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
  self.playerOne = MainPlayer.new("Player", 50, 100, nil, vector(100, 100), 50000, 10, 5, 100, interface)
  self.entityManager = EntityManager.new({self.playerOne}, world)
  self.camera = Camera(self.playerOne.pos.x*scale, self.playerOne.pos.y*scale)
  self.canvas = love.graphics.newCanvas()
end

function game:draw()
  love.graphics.setCanvas(self.canvas)
  love.graphics.clear()
  love.graphics.setDefaultFilter("nearest", "nearest", 1)
  self.camera:attach()
  self.world:draw(scale, 0, 0)
  self.camera:detach()
  love.graphics.setCanvas()
  love.graphics.draw(self.canvas, 0, love.graphics.getHeight(), 0, 1, -1)
  self.hotbar:draw()
end

function game:toWorld(x, y)
  local cx, cy = self.camera:worldCoords(x, love.graphics.getHeight() - y)
  return cx/scale, cy/scale
end

function game:drawBlocks()
  local x, y = self:toWorld(love.mouse.getX(), love.mouse.getY())
  self.world:set(x, y, self.hotbar:getSelected())
end

function game:update(dt)
  self.hotbar:update(dt)
  if isDrawing then
    self:drawBlocks()
  end
  self.entityManager:update(dt)
  local dx,dy = self.playerOne.pos.x*scale - self.camera.x, self.playerOne.pos.y*scale - self.camera.y
  self.camera:move(dx, dy)
end

function game:mousepressed()
  isDrawing = true
  self:drawBlocks()
end

function game:mousereleased()
  isDrawing = false
end
