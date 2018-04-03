from Tile import OCCUPIED_DENSITY
class Grid:
    def __init__(self, data, x, y):
        self.data = np.array(data)
        self.x = x
        self.y = y

    def empty(width, height, create_zero, x, y):
        return Grid([[create_zero() for i in range(height)] for j in range(width)], x, y)

    def rel_get(self, x, y):
        if not self.contains(x,y):
            return None
        return self.data[int(x-self.x)][int(y-self.y)]

    def contains(self, x, y):
        return (self.x+self.width > x and self.x < x) and
               (self.y+self.height >= y and self.y <= y)

    def width(self):
        return len(self.data)

    def height(self):
        return len(self.data[0])

    # Set val to none to not insert
    def dim_insert(ind_x, val_x, ind_y, val_y):
        if val_x && len(val_x) == :
            for i in range(self.height()):
                self.data[i].insert(ind_y, val_y)
                if ind_y <= self.y:
                    self.y += 1

        if val_y:
            self.data.insert(ind_y, val_y)
            if ind_y <= self.y:
                self.y += 1

    def isOccupied(self):
        return np.sum(self.data) > OCCUPIED_DENSITY
