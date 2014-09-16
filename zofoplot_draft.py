
import numpy as np

import matplotlib.pyplot as plt

class Item:
    '''Base class for all things that can be styled'''
    
    def __init__(self, classes):
        self._classes = classes
        self._style = {}
        self._resolved_style = None

    def set_style(self, key, value):
        self._style[key] = value

    def get_style(self, key, default = None):
        if self._resolved_style is None:
            raise "Styles have not been resolved yet"
        
        return self._resolved_style.get(key, default)

class Point(Item):
    pass

class Series(Item):
    def __init__(self, x, y, label, classes = None):
        super(Series, self).__init__(classes)
        self._x = x
        self._y = y
        self._label = label
        
        self._classes = classes

    def render(self, ax):
        ax.plot(self._x, self._y)
    


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
    

class StyleElement:
    def __init__(self, scope, key, value):
        self.key = key
        self.value = value
        
        pass


x = np.arange(-2, 2, 0.2)

chart = Chart()
linear    = chart.add_series(x=x, y=x**1, label="Linear"   , classes="odd" )
quadratic = chart.add_series(x=x, y=x**2, label="Quadratic", classes="even")
cubic     = chart.add_series(x=x, y=x**3, label="Cubic"    , classes="odd" )


linear.set_style("marker.area.color", "#ffff00")


chart.show()


'''
series["linear"   ].marker.shape = "o"
series["quadratic"].marker.shape = "s"
series["cubic"    ].marker.shape = "d"

series             .marker.filled = "true"
series["even"     ].marker.filled = "false"

'''





