vector = require 'lib/hump.vector'

DEFAULT = {
  jump = "space",
  left = "a",
  right = "d",
}

KeyboardInterface = {}
KeyboardInterface.__index = KeyboardInterface 

function KeyboardInterface.new(binding)
  self = {}
  if not binding then
    self.binding = DEFAULT
  else
    self.binding = binding
  end
  setmetatable(self, KeyboardInterface)
  return self
end

function KeyboardInterface:shouldJump()
  if love.keyboard.isDown(self.binding.jump) then
    return true
  else
    return false
  end
end


function KeyboardInterface:moveRight()
  if love.keyboard.isDown(self.binding.right) then
    return true
  else
    return false
  end
end


function KeyboardInterface:moveLeft()
  if love.keyboard.isDown(self.binding.left) then
    return true
  else
    return false
  end
end

