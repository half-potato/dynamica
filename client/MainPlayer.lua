require 'core/Player'

MainPlayer = Player.new("This type should not appear", 0, 0, nil)
MainPlayer.__index = MainPlayer

-- x, y = top left corner
function MainPlayer.new(name, x, y, collider, maxSpeed, mass, health, accel, jumpStrength, interface)
  self = Player.new(name, x, y, collider, maxSpeed, mass, health, accel, jumpStrength)
  setmetatable(self, MainPlayer)
  print(interface)
  self.interface = interface
  return self
end

function MainPlayer:update(dt, gravityVec)
  if self.interface:shouldJump() then
    self:jump()
  end
  if self.interface:moveRight() then
    self:moveRight()
  end
  if self.interface:moveLeft() then
    self:moveLeft()
  end
  Player.update(self, dt, gravityVec)
  --print(string.format("Player Pos: %f, %f", self.desiredPos.x, self.desiredPos.y))
end
