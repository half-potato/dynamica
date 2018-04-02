require 'core/MultiArray'

width = 5
height = 8
a = MultiArray:new({width = width, height = height})
print(a)
for i = 0,width-1 do
  for j = 0, height-1 do
    a:set(i, j, i+j)
    if a:get(i, j) ~= i+j then
      print(string.format("Failed indexing check at %i, %i, with val " .. a:get(i,j) .. " expected " .. i+j+dx+dy, i, j))
    end
  end
end
print(a)

dx = 1
dy = 0
a = a:shrink(dx,1,dy,1)
print(a)
a = a:grow(dx,1,dy,1)
print(a)
