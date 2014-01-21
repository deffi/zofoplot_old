require_relative 'container'
require_relative 'element'

module ZofoPlot
	class Tics
		include Container
		include Element
		# TODO color and font
		# TODO positions, manual positions/text, minor tics

		zofo_attributes :visible
		zofo_attributes :mirror, :is_outside
		zofo_attributes :rotation

		def initialize
			@visible=true
			@is_outside=false
		end

		def none   ; @visible=false; end
		def outside; @visible=true ; @is_outside=true ; end
		def inside ; @visible=true ; @is_outside=false; end

		def to_gnuplot(axis_name)
			parts=[]
			if @visible
				parts << "set #{axis_name}tics"
				parts << (@is_outside?"out":"in")
				parts << "rotate by #{@rotation}" if @rotation
			else
				parts << "unset #{axis_name}tics"
			end

			parts.join(' ')
		end
	end
end

