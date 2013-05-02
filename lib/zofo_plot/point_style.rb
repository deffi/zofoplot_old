require_relative 'container'
require_relative 'element'

module ZofoPlot
    class PointStyle
        include Container
        include Element

        zofo_attributes :shape, :color
        
        def self.shape_to_gnuplot(point_type)
            case point_type
            when Numeric               then point_type
            when :none                 then -1
            when :dot                  then  0
            when :plus                 then  1
            when :cross                then  2
            when :star                 then  3
            when :open_square          then  4
            when :filled_square        then  5
            when :open_circle          then  6
            when :filled_circle        then  7
            when :open_triangle_up     then  8
            when :filled_triangle_up   then  9
            when :open_triangle_down   then 10
            when :filled_triangle_down then 11
            when :open_diamond         then 12
            when :filled_diamond       then 13
            else raise ArgumentError, "Invalid point type #{point_type.inspect}"
            end
        end

        def to_gnuplot
            shape_string=@shape?("pointtype #{PointStyle.shape_to_gnuplot(@shape)}"):("")
            "#{shape_string}"
        end
    end
end

