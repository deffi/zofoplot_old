require_relative 'container'
require_relative 'element'
require_relative 'color'

module ZofoPlot
    class Border
        include Container
        include Element

        zofo_attribute :color, Color
        zofo_attributes :left, :right, :bottom, :top
                
        def initialize
            @left =@bottom=true
            @right=@top   =false
            
            @color=Color.new
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
            
            parts=[]

            parts << "set border #{value}"
            parts << "back"
            parts << "linecolor #{@color.to_gnuplot}" if @color
            parts << "linetype 1"
            parts << "linewidth 1"

            parts.join(' ')
        end
    end
end
