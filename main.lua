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
  grids[1] = Grid.empty(5, 6, create_air, 1, 0, 0)
  world[1] = RotatingGrid.new(grids, 0, 0, 0)
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
