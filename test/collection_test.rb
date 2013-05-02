#!/usr/bin/env ruby

require 'test/unit'

require_relative "../lib/zofo_plot"

module ZofoPlot
    class CollectionTest <Test::Unit::TestCase
        class MyColor
            include ZofoPlot::Container
            include ZofoPlot::Element

            zofo_attributes :red, :green, :blue
            def initialize(*args)
                if args.empty?
                    @red=@green=@blue=0
                elsif args.size==1 && args[0].is_a?(String) && args[0] =~ /^ [#]? (\h{2}) (\h{2}) (\h{2}) $ /x
                    @red  =$1.to_i(16)
                    @green=$2.to_i(16)
                    @blue =$3.to_i(16)
                elsif args.size==3
                    @red, @green, @blue = args
                else
                    raise ArgumentError, "Invalid parameters for MyColor"
                end
            end

            def to_a
                [@red, @green, @blue]
            end
        end
        
        def test_add
            def check_color(collection)
                collection.each { |element|
                    assert_equal MyColor, element.class
                    assert_equal [0, 127, 255], element.to_a
                }
            end

            my_color_collection=Collection.new(MyColor)
            
            # Add a value of the expected class            
            my_color_collection.add MyColor.new(0, 127, 255)
            check_color(my_color_collection)
            
            # Construct a value from a single argument
            my_color_collection.add "#007fff"
            check_color(my_color_collection)
            
            # Construct a value from multiple arguments
            my_color_collection.add 0, 127, 255
            check_color(my_color_collection)

            # Default-construct a value and set the values using a block 
            my_color_collection.add { red 0; green 127; blue 255 }
            check_color(my_color_collection)
            
            # Construct a value *and* override some values using a block
            my_color_collection.add(0, 127, 0) { blue 255 }
            check_color(my_color_collection)
        end
    end
end
