require 'core/Entity'

PhysicalEntity = Entity.new("This type should not appear", 0, 0, nil)
PhysicalEntity.__index = PhysicalEntity

function PhysicalEntity.init(o)
  self = Entity.new(o)
  setmetatable(self, PhysicalEntity)
  return self
end

-- x, y = top left corner
function PhysicalEntity.new(name, x, y, collider, maxSpeed, mass)
  self = Entity.new(name, x, y, collider, maxSpeed)
  setmetatable(self, PhysicalEntity)
  self.mass = mass
  return self
end

function PhysicalEntity:update(dt, gravityVec)
  self.netAccel = self.netAccel + gravityVec
  Entity.update(self, dt)
end
