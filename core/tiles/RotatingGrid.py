import math
from MetaGrid import MetaGrid

class RotatingGrid(MetaGrid):
    def __init__(self, grids, angle=0, x, y):
        MetaGrid.__init__(grids, x, y)
        self.angle = angle
        self.center_x = x
        self.center_y = y

    def get_rel_xy(x, y):
        cx = x - self.center_x
        cy = y - self.center_y
        theta = math.atan2(cy, cx)
        mag = sqrt(cx**2 + cy**2)
        return mag*cos(theta+self.angle) + self.center_x,
               mag*sin(theta+self.angle) + self.center_y

    def update_center(self):
        sum_x = 0
        sum_y = 0
        n = 0
        for g in self.grids:
            n += g.width() + g.height()
            xm, ym = np.meshgrid(g.data.shape)
            sum_x += np.sum(np.multiply(g.data, xm))
            sum_y += np.sum(np.multiply(g.data, ym))
        return sum_x/n, sum_y/n

    def add_grid(self, grid):
        MetaGrid.add_grid(self, grid)
        update_center()
