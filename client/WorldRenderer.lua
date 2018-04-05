require 'client/RotatingGridRenderer'
require 'core/World'

function World:draw(scale, screenox, screenoy)
  for i=1,#self.grids do
    self.grids[i]:draw(scale, screenox, screenoy)
  end
end
