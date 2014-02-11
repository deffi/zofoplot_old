require_relative 'container'
require_relative 'element'

module ZofoPlot
    class DefaultPoint
        include Container
        include Element

        zofo_attributes :x, :y, :x_range, :y_range
        
        def initialize(x=nil, y=nil, x_range=nil, y_range=nil)
            @x=x
            @y=y
            @x_range=x_range
            @y_range=y_range
        end
    end
end

