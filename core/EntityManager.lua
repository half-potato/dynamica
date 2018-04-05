require 'core/Entity'

EntityManager = {}
EntityManager.__index = EntityManager 

function EntityManager.new(entities, world)
  local self = {}
  setmetatable(self, EntityManager)
  self.entities = entities
  self.world = world
  return self
end

function EntityManager:update(dt)
  local gravity = vector(0, -9.81)
  for i=1,#self.entities do
    local entity = self.entities[i]
    -- Calculate gravity
    entity:update(dt, gravity)
    -- Deal with collision
    entity.pos = entity.desiredPos
    -- Deal with other stuff
  end
end
