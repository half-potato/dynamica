require 'core/Entity'
require 'core/PhysicialEntity'
require 'core/NormalEntity'
require 'core/MortalEntity'
require 'core/Player'
require 'core/Entity'

ENTITIES = {
}

ENTITIES_NAME_LIST = {
  "Player",
  "Cow",
}

for i=1,#TILE_NAME_LIST do
  table.insert(ENTITIES, require(string.format('core/entities/%s', ENTITIES_NAME_LIST[i])))
end
