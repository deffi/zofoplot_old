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
