json = require "lib/json"

OCCUPIED_DENSITY = 0.01

function readAll(file)
  local f = assert(io.open(file, "rb"))
  local content = f:read("*all")
  f:close()
  return content
end

-- Values taken from: https://www.engineeringtoolbox.com
local mat_vals_json = readAll("assets/materials.json", "r")
if not mat_vals_json then
  error("Failed to load assets/materials.json")
end
MAT_VALS = json.decode(mat_vals_json)

function json_retrieve(name, val_key)
  return MAT_VALS[name][val_key]
end

PROP_NAMES = {
  "texture",
  "density", -- g/cm
  "melting_point",
  "thermal_conductivity",
  "radiation_constant",
  "electrical_resistivity",
  "magnetic_attraction",
  "magnetism",
  "tensile_strength",
  "specific_heat",
  --"ph",
  --"solubility_ph",
  --"solubility_C",
}

Tile = {}
Tile.__index = Tile
-- props is a map of values to add to the tile.
-- If a property is not found it is looked up in assets/materials.json
-- optional argument: array of similar materials to lookup props in
function Tile.new(name, props, ...)
  local self = {}
  local similar = ...
  setmetatable(self, Tile)
  self.name = name
  -- Assign properties
  for i=1,#PROP_NAMES do
    if props and props[PROP_NAMES[i]] then
      -- assign from argument
      self[PROP_NAMES[i]] = props[PROP_NAMES[i]]
    elseif MAT_VALS[name] and MAT_VALS[name][PROP_NAMES[i]] then
      self[PROP_NAMES[i]] = MAT_VALS[name][PROP_NAMES[i]]
    elseif similar then
      for j=1,#similar do
        if MAT_VALS[similar[j]] and MAT_VALS[similar[j]][PROP_NAMES[i]] then
          self[PROP_NAMES[i]] = MAT_VALS[similar[j]][PROP_NAMES[i]]
        end
      end
    end
  end
  return self
end

function Tile:isOccupied()
  if self.density then
    return self.density > OCCUPIED_DENSITY
  else
    return false
  end
end
