require_relative 'container'
require_relative 'element'

module ZofoPlot
    class Axis
        include Container
        include Element

        zofo_attributes :range, :is_logarithmic, :label
        zofo_attributes :tics
        zofo_attributes :format
        
        def initialize
            @is_logarithmic=nil
            @range=nil
            @tics=Tics.new
            @format=nil
        end

        def logarithmic
            is_logarithmic true
        end

        def linear
            is_logarithmic false
        end

        # Use: x_axis { format exponential }
        # TODO change:
        #   * potential name collisions
        #   * should be format { exponential }
        def exponential
            '10^{%L}'
        end
        
        def to_gnuplot(axis_name)
            lines=[]
            lines << "set #{axis_name}range [#{range[0]}:#{range[1]}]" if @range
            lines << "set #{axis_name}label '#{@label}'" if @label
            lines << "set logscale #{axis_name}" if @is_logarithmic
            lines << "set format #{axis_name} #{format.to_gnuplot}" if @format

            lines << @tics.to_gnuplot(axis_name)
            lines.join("\n")
        end
    end
end
