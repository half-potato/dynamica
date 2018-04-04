require 'core/tiles/load'
require 'core/RotatingGrid'
require 'core/Grid'
require 'core/Tile'
require 'client/load_textures'
require 'client/RotatingGridRenderer'

world = {}

function love.load()
  grids = {}
  function create_air()
    return Tile.new("Air", {})
  end
  grids[1] = Grid.empty(100, 100, create_air, 1, 0, 0)
  -- F
  grids[1].data[10][10] = Tile.new("Marble", {})
  grids[1].data[11][10] = Tile.new("Marble", {})
  grids[1].data[12][10] = Tile.new("Marble", {})
  grids[1].data[10][11] = Tile.new("Marble", {})
  grids[1].data[10][12] = Tile.new("Marble", {})
  grids[1].data[11][12] = Tile.new("Marble", {})
  grids[1].data[12][12] = Tile.new("Marble", {})
  grids[1].data[10][13] = Tile.new("Marble", {})
  grids[1].data[10][14] = Tile.new("Marble", {})

  -- U
  grids[1].data[14][10] = Tile.new("Marble", {})
  grids[1].data[14][11] = Tile.new("Marble", {})
  grids[1].data[14][12] = Tile.new("Marble", {})
  grids[1].data[14][13] = Tile.new("Marble", {})
  grids[1].data[15][14] = Tile.new("Marble", {})
  grids[1].data[16][14] = Tile.new("Marble", {})
  grids[1].data[17][10] = Tile.new("Marble", {})
  grids[1].data[17][11] = Tile.new("Marble", {})
  grids[1].data[17][12] = Tile.new("Marble", {})
  grids[1].data[17][13] = Tile.new("Marble", {})

  -- C
  grids[1].data[19][10] = Tile.new("Marble", {})
  grids[1].data[20][10] = Tile.new("Marble", {})
  grids[1].data[21][10] = Tile.new("Marble", {})
  grids[1].data[19][10] = Tile.new("Marble", {})
  grids[1].data[19][11] = Tile.new("Marble", {})
  grids[1].data[19][12] = Tile.new("Marble", {})
  grids[1].data[19][13] = Tile.new("Marble", {})
  grids[1].data[19][14] = Tile.new("Marble", {})
  grids[1].data[20][14] = Tile.new("Marble", {})
  grids[1].data[21][14] = Tile.new("Marble", {})

  -- K
  grids[1].data[25][10] = Tile.new("Marble", {})
  grids[1].data[23][10] = Tile.new("Marble", {})
  grids[1].data[25][11] = Tile.new("Marble", {})
  grids[1].data[23][11] = Tile.new("Marble", {})
  grids[1].data[23][12] = Tile.new("Marble", {})
  grids[1].data[24][12] = Tile.new("Marble", {})
  grids[1].data[23][13] = Tile.new("Marble", {})
  grids[1].data[25][13] = Tile.new("Marble", {})
  grids[1].data[23][14] = Tile.new("Marble", {})
  grids[1].data[25][14] = Tile.new("Marble", {})
  world[1] = RotatingGrid.new(grids, 0, 0, math.pi/8)
end

function love.draw()
  for i=1,#world do
    world[i]:draw(16, 0, 0)
  end
end

function love.update()
end

--[[

local socket = require "socket"

local address, port = "localhost", 8008

local entity
local updaterate = 0.1

local world = {}
local t

function love.load()
  udp = socket.udp()
  udp:settimeout(0)
  udp:setpeername(address, port)
  math.randomseed(os.time())
  entity = tostring(math.random(99999))
  udp:send(string.format("%s %s %f %f", entity, "at", 320, 240))
  t = 0
end

function love.update(dt)
  t = t + dt
  if t > updaterate then
    local x, y = 0, 0
    if love.keyboard.isDown('up') then y=y-(20*t) end
    if love.keyboard.isDown('down') then y=y+(20*t) end
    if love.keyboard.isDown('left') then x=x-(20*t) end
    if love.keyboard.isDown('right') then x=x+(20*t) end

    local dg = string.format("%s %s %f %f", entity, "move", x, y)
    udp:send(dg)
    -- Request update
    local dg = string.format("%s %s $", entity, 'update')
    udp:send(dg)
    t = t - updaterate
  end
  repeat
    data, msg = udp:receive()
    if data then
      ent, cmd, parms = data:match("^(%S*) (%S*) (.*)")
      print(data)
      if cmd == 'at' then
        local x, y = parms:match("^(%-?[%d.e]*) (%-?[%d.e]*)$")
        assert(x and y)
        x, y = tonumber(x), tonumber(y)
        world[ent] = {x=x, y=y}
      else
        print("unrecognized command:", cmd)
      end
    elseif msg ~= 'timeout' then
      error("Networkr error: "..tostring(msg))
    end
  until not data
end

function love.draw()
  for k, v in pairs(world) do
    love.graphics.print(k, v.x, v.y)
  end
end
]]--
