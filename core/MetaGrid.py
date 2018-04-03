class MetaGrid:
    def __init__(self, grids=[], x, y):
        self.grids = grids
        self.x = x
        self.x = y

    def get_rel_xy(x, y):
        return x-self.x, y-self.y

    # Iterator
    def grids_at(self, x, y, ignored_grids_ind=[]):
        for i, v in enumerate(self.grids):
            if i in ignored_grids_ind:
                continue
            if v.contains(x, y):
                yield v

    def tiles_at(self, x, y, ignored_grids_ind=[]):
        for i in self.grids_at(x, y, ignored_grids_ind):
            t = i.rel_get(x, y)
            if t:
                yield t

    def check_overlap(self, grid, dx=0, dy=0, ignored_grids_ind=[]):
        for x in range(grid.width()):
            for y in range(grid.height()):
                if grid.data[x][y] and i.isOccupied():
                    cx, cy = sefl.get_rel_xy(x, y)
                    for i in self.tiles_at(cx+grid.x+dx, cy+grid.y+dy, ignored_grids_ind):
                        if i and i.isOccupied():
                            return True
        return False

    def move_grid(self, g_index, dx, dy):
        if not self.check_overlap(self.grids[g_index],
                dx=dx, dy=dy, ignored_grids_ind=[g_index]):
            self.grids[g_index].x += dx
            self.grids[g_index].y += dy
            return True
        return False

    def add_grid(self, grid):
        if not self.check_overlap(grid):
            self.grids.append(grid)
            return True
        return False

    def remove_grid(self, g_index):
        return self.grids.pop(g_index)
