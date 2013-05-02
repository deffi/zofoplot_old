require_relative 'container'
require_relative 'element'

module ZofoPlot
    class Chart
        include Container
        include Element

        attr_reader :data_sets
        
        zofo_attributes :x_axis, :y_axis
        zofo_attributes :title
        zofo_attributes :border
        zofo_attributes :raw_lines
        
        def initialize
            @data_sets=Collection.new(DataSet)
            @x_axis=Axis.new
            @y_axis=Axis.new
            @border=Border.new
            @raw_lines=[]
        end

        def to_gnuplot
            # We must restore the settings to their default values, so the next
            # chart will not be influenced by this chart's settings (starting a
            # new Gnuplot instance for every chart is slow and doesn't work for
            # multiplots). However, we cannot use the reset command as this
            # will also reset the multiplot setting (if it is set).

            setfile=Tempfile.new('zofoplot')

            lines=[]

            lines << "save set '#{setfile.path}'"

            lines << @x_axis.to_gnuplot("x") if @x_axis
            lines << @y_axis.to_gnuplot("y") if @y_axis

            lines << @border.to_gnuplot

            lines << "set arrow from graph 1,0 to graph 1.02,0 size screen 0.010,15,60 filled linewidth 1" # Horizontal
            lines << "set arrow from graph 0,1 to graph 0,1.03 size screen 0.010,15,60 filled linewidth 1" # Vertical

            lines << "set title #{@title.to_gnuplot}" if @title

            lines << @raw_lines.join("\n")

            lines << "plot " + @data_sets.map { |ds| ds.to_gnuplot_command }.join(", ")
            @data_sets.each { |data_set|
                data_string=data_set.to_gnuplot_data
                if data_string
                    lines << data_string
                end
            }

            lines << "load '#{setfile.path}'"

            lines.join("\n")
        end
    end
end

