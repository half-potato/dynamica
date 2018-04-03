json = require "json"

OCCUPIED_DENSITY = 0.01

-- Values taken from: https://www.engineeringtoolbox.com
local mat_vals_json = io.open("assets/materials.json", "r")
if not mat_vals_json then
  error("Failed to load assets/materials.json")
end
MAT_VALS = json.decode(mat_vals_json)

function json_retrieve(name, val_key):
    return MAT_VALS[name].get(val_key)

PROP_NAMES = {
  "density",
  "melting_point",
  "thermal_conductivity",
  "thermal_radiation",
  "electrical_resistance",
  "magnetic_attraction",
  "magnetism",
  "tensile_strength",
  "ph",
  "solubility_ph",
  "solubility_C",
}

Tile = {}
Tile.__index = Tile
-- props is a map of values to add to the tile.
-- If a property is not found it is looked up in assets/materials.json
function Tile:new(name, props)
  local self = {}
  setmetatable(self, Tile)
  self.name = name
  -- Assign properties
  for i in PROP_NAMES do
    if props and props[i] then
      -- assign from argument
      self[i] = props[i]
    else
      -- lookup in json
      if MAT_VALS[name] then
        self[i] = MAT_VALS[name][i]
      else
        print("Failed to load property " .. i .. " of Tile " .. name)
      end
    end
  end
end

function Tile:isOccupied()
  if self.density then
    return self.density > OCCUPIED_DENSITY
  else
    return false
  end
end
