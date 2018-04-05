require 'core/PhysicalEntity'

NormalEntity = PhysicalEntity.new("This type should not appear", 0, 0, nil)
NormalEntity.__index = NormalEntity

-- x, y = top left corner
function NormalEntity.new(name, x, y, collider, maxSpeed, mass, health, accel, jumpStrength)
  self = PhysicalEntity.new(name, x, y, collider, maxSpeed, mass)
  setmetatable(self, NormalEntity)
  self.health = health
  self.maxSpeed = maxSpeed
  self.accel = accel
  self.jumpStrength = jumpStrength
  -- Collider needs to set this to nil for you to jump again
  self.currentJumpStrength = nil
  return self
end

function NormalEntity:moveRight()
  self.netAccel = self.netAccel + vector(self.accel, 0)
end

function NormalEntity:moveLeft()
  self.netAccel = self.netAccel + vector(-self.accel, 0)
end

function NormalEntity:jump()
  if not self.currentJumpStrength then
    self.currentJumpStrength = vector(0, self.jumpStrength)
  elseif self.currentJumpStrength:len() > 0 then
    self.netAccel = self.netAccel + self.currentJumpStrength
  end
end

function NormalEntity:update(dt, gravityVec)
  self.netAccel = self.netAccel + gravityVec
  if self.currentJumpStrength and self.currentJumpStrength:len() > 0 then
    self.currentJumpStrength = self.currentJumpStrength + gravityVec
  end
  Entity.update(self, dt)
end
