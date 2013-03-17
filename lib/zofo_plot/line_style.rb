require_relative 'container'
require_relative 'element'

module ZofoPlot
	class LineStyle
		include Container
		include Element

		zofo_attributes :color, :width

		def initialize
		end

		def to_gnuplot
			color_string=@color?("linecolor rgb '#{@color}'"):("")
			width_string=@width?("linewidth #{@width}"):("")
			"#{color_string} #{width_string}"
		end
	end
end

