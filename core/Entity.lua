vector = require 'lib/hump.vector'

Entity = {}
Entity.__index = Entity

-- x, y = top left corner
function Entity.new(name, x, y, collider, maxSpeed)
  self = {}
  setmetatable(self, Entity)
  self.name = name
  self.pos = vector(x, y)
  self.desiredPos = vector(x, y)
  self.netAccel = vector(0, 0)
  self.velocity = vector(0, 0)
  self.collider = collider
  self.maxSpeed = maxSpeed
  return self
end

function Entity:update(dt)
  self.velocity = self.netAccel * dt
  self.netAccel = vector(0, 0)
  if self.velocity.x > self.maxSpeed.x then
    self.velocity.x  = self.maxSpeed.x 
  end
  if self.velocity.y > self.maxSpeed.y then
    self.velocity.y  = self.maxSpeed.y 
  end
  self.desiredPos = self.pos + self.velocity * dt
end
