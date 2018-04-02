require 'core/classes.lua'

Tile = class(function()
  function __init(name)
  end
end)

--[[
import json

OCCUPIED_DENSITY = 0.01

with open("materials.json", "r") as f:
    MAT_VALS = json.loads(f.readlines)

def json_retrieve(name, val_key):
    return MAT_VALS[name].get(val_key)

PROP_NAMES = [
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
]

"""
Resources
  https://www.engineeringtoolbox.com/thermal-conductivity-d_429.html

"""
class Tile:
    def __init__(self, name, **kwargs):
        self.name = name
        for i in PROP_NAMES:
            self.__setattr__(i, kwargs.get(i))

    def vals_from_json(self, name):
        t = Tile(name)
        for i in PROP_NAMES:
            t.__setattr__(i, json_retrieve(name, i))

    def __add__(self, value):
        return self.density + value.density

    def __mul__(self, value):
        return self.density * value.density

    def isOccupied(self):
        return self.density > OCCUPIED_DENSITY
]]--
