require_relative 'container'
require_relative 'element'

module ZofoPlot
    class Legend
        include Container
        include Element

        zofo_attributes :box, :box, :is_opaque, :width, :reverse, :spacing
        zofo_attributes :is_inside, :position, :position_at
        
        def initialize
            @is_opaque=false
            @width=nil
            @reverse=true
            @spacing=1.2
            @is_inside=false
            @position="center right"
            @position_at=nil
        end

        def opaque     ; @is_opaque=true ; end
        def transparent; @is_opaque=false; end

        def inside ; @is_inside=true ; end
        def outside; @is_inside=false; end
        
        def center; @position="center"; end
        def top   ; @position="center top"   ; end
        def bottom; @position="center bottom"; end
        def left  ; @position="center left"  ; end
        def right ; @position="center right" ; end
        def top_left    ; @position="top left"    ; end
        def top_right   ; @position="top right"   ; end
        def bottom_left ; @position="bottom left" ; end
        def bottom_right; @position="bottom right"; end
        # TODO use top_left([x, y]) etc. 
        def at(x, y); @position_at="at #{x}, #{y}"; end
            
        def to_gnuplot
            parts=[]

            parts << "set key"
            parts << "box"                           if @box
            parts << "opaque"                        if @is_opaque
            parts << @position                       if @position
            parts << (@is_inside?"inside":"outside") if !@position_at
            parts << @position_at                    if @position_at
            parts << "width #{@width}"               if @width
            parts << "reverse Left"                  if @reverse
            parts << "spacing #{@spacing}"           if @spacing
            parts << "title #{@title.to_gnuplot}"    if @title
                
            parts.join(" ")
        end
    end
end
