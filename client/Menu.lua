local uare = require 'lib/uare'
Gamestate = require 'lib/hump.gamestate'
require 'client/Game'

menu = {}

local main_button_style = uare.newStyle({

  width = 400,
  height = 60,
  
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
      y = -30
    }
  },

})

local play = uare.new({
  text = {
    display = "Play"
  },
  x = love.graphics.getWidth()/2,
  y = love.graphics.getHeight()/2,
  center = true,
  onClick = function()
    uare.clear()
    love.graphics.setColor(255,255,255,255)
    Gamestate.switch(game)
  end
}):style(main_button_style)

function menu:update(dt)
  uare.update(dt, love.mouse.getX(), love.mouse.getY())
end

function menu:draw()
  uare.draw()
end
