local uare = require 'lib/uare'

Hotbar = {}
Hotbar.__index = Hotbar

local item_button = uare.newStyle({
  width = 80,
  height = 80,
  
  --color
  
  color = {200, 200, 200},
  
  hoverColor = {150, 150, 150},
  
  holdColor = {100, 100, 100},
  
  --border
  
  border = {
    color = {255, 255, 255},
  
    hoverColor = {200, 200, 200},
    
    holdColor = {150, 150, 150},
    
    size = 5
  },
  
  --text
  
  text = {
    color = {200, 0, 0},
    
    hoverColor = {150, 0, 0},
    
    holdColor = {255, 255, 255},
    
    font = love.graphics.newFont(48),
    
    align = "center",
    
    offset = {
      x = 0,
      y = 0
    }
  },
})

function Hotbar.new(x, y, selection)
  self = {}
  setmetatable(self, Hotbar)
  self.width = item_button.width*#selection
  self.height = item_button.width
  self.x = x
  self.y = y
  self.slots = {}
  self.selection = selection
  self.selected = 1
  for i=1,#selection do
    self:createSlot(i)
  end
  return self
end

function Hotbar:getSelected()
  return self.selection[self.selected]
end

function Hotbar:createSlot(number)
  local slot = uare.new({
    x = self.x+(number-1)*item_button.width,
    y = self.y,--+(number-1)*item_button.height,
  }):style(item_button)
  slot.onRelease = function()
    for i=1,#self.slots do
      self.slots[i]:enable()
    end
    slot:disable()
    slot.holdt = true
    self.selected = number
  end
  if number == self.selected then
    slot.onRelease()
  end
  table.insert(self.slots, slot)
end

function Hotbar:update(dt)
  uare.update(dt, love.mouse.getX(), love.mouse.getY())
end

function Hotbar:draw()
  uare.draw()
end
