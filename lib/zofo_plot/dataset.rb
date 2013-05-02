require_relative 'container'
require_relative 'element'

module ZofoPlot
    class DataSet
        include Container
        include Element

        zofo_attributes :line_style, :point_style
        zofo_attributes :points
        zofo_attributes :title
        
        def initialize(points=[])
            @points=points
            @line_style=LineStyle.new
            @point_style=PointStyle.new
            @title=nil
        end

        def to_gnuplot_command
            line_style =@line_style? (@line_style .to_gnuplot):("")
            point_style=@point_style?(@point_style.to_gnuplot):("")
            title      =@title?      ("title '#{@title}'"):("notitle")
            "'-' with linespoints #{line_style} #{point_style} #{title}"
        end

        def to_gnuplot_data
            lines=[]
            @points.each { |point|
                lines << "#{point.x} #{point.y}"
            }
            lines << "e"
            lines.join("\n")
        end
    end
end

