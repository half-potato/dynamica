local uare = require 'lib/uare'
require 'client/load_textures'

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
    y = self.y,
    content = {
      width = item_button.width - 10,
      height = item_button.height - 10,
    },
  }):style(item_button)
  slot:setContent(function(ref, alpha)
    love.graphics.setColor(255, 255, 255, alpha)
    local tex = TILE_TEXTURES[self.selection[number].name]
    if tex then
      love.graphics.draw(tex, 5,5, 0, (item_button.width-10)/tex:getWidth(),
                         (item_button.height-10)/tex:getHeight())
    else
      local q = TILE_QUADS[self.selection[number].name]
      love.graphics.draw(SPRITESHEET, q, 5,5, 0, (item_button.width-10)/TILE_W,
                         (item_button.height-10)/TILE_H)
    end
  end)

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
