require 'core/Player'

return NormalEntity({
  name="Player", 
  x=0,
  y=0,
  collider=nil,
  maxSpeed=12,
  mass=55,
  health=20,
  accel=9,
  jumpStrength=3,
  texture="entities/defaultPlayer.png"
})

