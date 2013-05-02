require_relative 'container'
require_relative 'element'

module ZofoPlot
    class Axis
        include Container
        include Element

        zofo_attributes :range, :is_logarithmic, :label
        zofo_attributes :tics
        
        def initialize
            @is_logarithmic=nil
            @range=nil
            @tics=Tics.new
        end

        def logarithmic
            is_logarithmic true
        end

        def linear
            is_logarithmic false
        end

        def to_gnuplot(axis_name)
            lines=[]
            lines << "set #{axis_name}range [#{range[0]}:#{range[1]}]" if @range
            lines << "set logscale #{axis_name}" if @is_logarithmic
            lines << "set #{axis_name}label '#{@label}'" if @label
            lines << @tics.to_gnuplot(axis_name)
            lines.join("\n")
        end
    end
end

