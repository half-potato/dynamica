require 'core/NormalEntity'

Player = NormalEntity.new("This type should not appear", 0, 0, nil)
Player.__index = Player

-- x, y = top left corner
function Player.new(name, x, y, collider, maxSpeed, mass, health, accel, jumpStrength)
  local self = NormalEntity.new(name, x, y, collider, maxSpeed, mass, health, accel, jumpStrength)
  setmetatable(self, Player)
  return self
end
