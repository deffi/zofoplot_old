require_relative 'container'
require_relative 'element'

module ZofoPlot
	class MultiChart
		include Container
		include Element

		zofo_attributes :charts, :rows, :columns

		def initialize
			@charts=[]
			@rows=nil
			@columns=nil
		end

		def to_gnuplot
			lines=[]

			if @rows.nil? and @columns.nil?
				rows   =Math::sqrt(@charts.size).ceil
				columns=rows
			elsif @rows.nil?
				rows   =(@charts.size/@columns).ceil
				columns=@columns
			elsif @columns.nil?
				rows   =@rows
				columns=(@charts.size/@rows).ceil
			else
				rows   =@rows
				columns=@columns
			end

			#set multiplot  
			#set size 0.4,0.4  
			#set origin 0.1,0.1  

			width =1.0/columns
			height=1.0/rows

			# We cannot use "set multiplot layout..." because the individual
			# charts will restore the settings after it is plotted (see
			# Chart::to_gnuplot), so we'll calculate the positions manually.

			#lines << "set multiplot layout #{rows},#{columns} title 'A multiplot!'"
			lines << "set multiplot"
			
			@charts.each_with_index { |chart, index|
				raise "A multiplot can only contain charts" unless chart.is_a?(Chart)
				row   =index/columns
				column=index%columns

				lines << "set size #{width},#{height}"
				lines << "set origin #{width*column},#{height*(rows-row-1)}"
				#puts "origin to #{width*column}, #{height*(rows-row-1)}"
				lines << chart.to_gnuplot
			}

			lines << "unset multiplot"

			lines.join("\n")
		end
	end
	
end

