require_relative 'container'
require_relative 'element'

module ZofoPlot
    class Border
        include Container
        include Element

        zofo_attributes :left, :right, :bottom, :top
                
        def initialize
            @left =@bottom=true
            @right=@top   =false
        end
        
        def all
            @left=@bottom=@right=@top=true
        end
        
        def none
            @left=@bottom=@right=@top=false
        end
        
        def to_gnuplot
            value=0
            value += 1 if @bottom
            value += 2 if @left
            value += 4 if @top
            value += 8 if @right
            
            "set border #{value} back linecolor rgb '#000000' linetype 1 linewidth 1"
        end
    end
end
