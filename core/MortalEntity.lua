require 'core/PhysicalEntity'

MortalEntity = PhysicalEntity.new("This type should not appear", 0, 0, nil)
MortalEntity.__index = MortalEntity

function MortalEntity.init(self)
  self = PhysicalEntity.new(self)
  setmetatable(self, MortalEntity)
  return self
end

-- x, y = top left corner
function MortalEntity.new(name, x, y, collider, mass, health, maxSpeed, accel)
  self = PhysicalEntity.new(name, x, y, collider, mass)
  setmetatable(self, MortalEntity)
  self.health = health
  self.speed = speed
  return self
end
