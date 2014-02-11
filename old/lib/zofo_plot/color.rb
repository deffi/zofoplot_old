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

        def self.color_names
            @color_names ||= { 
                "red"   => [255, 0, 0],
                "green" => [0, 255, 0],
                "blue"  => [0, 0, 255],
                
                "yellow"  => [255, 255, 0],
                "magenta" => [255, 0, 255],
                "cyan"    => [0, 255, 255],
    
                "black"  => [0, 0, 0],
                "white"  => [255, 255, 255],
            }
        end
        
        zofo_attributes :red, :green, :blue
        def initialize(*args)
            if args.size==0
                # No arguments - black
                @red = @green = @blue = 0
            elsif args.size==1
                arg=args[0]
                if arg.is_a?(Array) and arg.size==3
                    # Array with 3 members
                    arg.each { |num|
                        if num<0 || num>255
                            raise ArgumentError, "Number out of range (0..255): #{num}"
                        end
                    }
                    @red, @green, @blue = arg
                elsif arg.is_a?(String)
                    # String
                    if arg =~ /^ [#]? (\h{2}) (\h{2}) (\h{2}) $ /x
                        @red  =$1.to_i(16)
                        @green=$2.to_i(16)
                        @blue =$3.to_i(16)
                    elsif Color.color_names.has_key?(arg)
                        @red, @green, @blue = Color.color_names[arg]
                    else
                        raise ArgumentError, "Unsupported string to create a color: #{arg.inspect}"
                    end
                elsif arg.is_a?(Numeric)
                    if arg>=0 && arg<=255
                        @red=@green=@blue=arg.to_i
                    else
                        raise ArgumentError, "Number out of range (0..255): #{arg}"
                    end
                else
                    raise ArgumentError, "Unsupported parameters to create a color: #{args.inspect}"
                end
            elsif args.size==3
                # 3 individual arguments
                args.each { |num|
                    if num<0 || num>255
                        raise ArgumentError, "Number out of range (0..255): #{num}"
                    end
                }
                @red, @green, @blue = args
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
