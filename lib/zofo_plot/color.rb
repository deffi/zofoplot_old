require_relative 'container'
require_relative 'element'

module ZofoPlot
    # Ways to create a color:
    #   * RGB as individual parameters:    Color.new(0, 127, 255)
    #   * RGB as array:                    Color.new([0, 127, 255])
    #   * HTML notation:                   Color.new("#007fff")
    #   * HTML notation without hash sign: Color.new("007fff")
    class Color
        include Container
        include Element

        zofo_attributes :red, :green, :blue
        def initialize(*args)
            if args.size==0
                # No arguments - black
                @red = @green = @blue = 0
            elsif args.size==3
                # 3 individual arguments
                @red, @green, @blue = args
            elsif args.size==1 and args[0].is_a?(Array) and args[0].size==3
                # Array with 3 members
                @red, @green, @blue = args[0]
            elsif args.size==1 and args[0].is_a?(String)
                # String
                string=args[0]
                if string =~ /^ [#]? (\h{2}) (\h{2}) (\h{2}) $ /x
                    @red  =$1.to_i(16)
                    @green=$2.to_i(16)
                    @blue =$3.to_i(16)
                else
                    raise ArgumentError, "Unsupported string to create a color: #{string.inspect}"
                end
            else
                raise ArgumentError, "Unsupported parameters to create a color: #{args.inspect}"
            end
        end

        def ==(other)
            self.to_a == other.to_a
        end
        
        def to_a
            [@red, @green, @blue]
        end

        def to_gnuplot
            Kernel.sprintf("rgb '#%02x%02x%02x'", red, green, blue)
        end
    end
end
