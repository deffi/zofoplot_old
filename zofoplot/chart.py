class Chart(Item):
    def __init__(self):
        self._serien = []
        self._x_axis = None
        self._y_axis = None
        
    def add_series(self, x, y, label, classes = None):
        series = Series(x, y, label, classes)
        self._serien.append(series)
        return series

    def render(self, ax):
        for series in self._serien:
            series.render(ax)

    def show(self):
        fig = plt.figure(dpi=100, figsize=(5,4)) # Size in inches
        ax = fig.add_subplot(111)
        self.render(ax)
        plt.show()
