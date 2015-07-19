class Series(Item):
    def __init__(self, x, y, label, classes = None):
        super(Series, self).__init__(classes)
        self._x = x
        self._y = y
        self._label = label
        
        self._classes = classes

    def render(self, ax):
        ax.plot(self._x, self._y)
