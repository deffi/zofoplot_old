#!/usr/bin/env ruby

require 'test/unit'

require_relative "../lib/zofo_plot"

module ZofoPlot
	class ContainerTest <Test::Unit::TestCase
		class MyColor
		    include ZofoPlot::Container
		    
		    zofo_attributes :red, :green, :blue
		    
		    def initialize(*args)
		      if args.size==3
		        @red, @green, @blue = args
		      elsif args.size==1 && args[0].is_a?(String) && args[0] =~ /^ [#]? (\h{2}) (\h{2}) (\h{2}) $ /x
            @red  =$1.to_i(16)
            @green=$2.to_i(16)
            @blue =$3.to_i(16)
          end
		    end
		    
		    def to_a
		      [@red, @green, @blue]
		    end
		end
		
		class MyLine
		    include ZofoPlot::Container
		    
		    zofo_attribute :color, MyColor
		    zofo_attributes :width, :name
		end
		
		# A class which also defines a color attribute, but without no default
		# classes (at all)
		class MyOther
		  include ZofoPlot::Container
		  zofo_attributes :color
		end
		
		def test_zofo_attributes
		  # The MyOther class must have an empty hash of zofo attributes
		  assert_equal Hash.new, MyOther.zofo_attributes
		end
		
		def test_attributes
		  my_color=MyColor.new
      assert_nothing_raised       { my_color.red 0 }
      assert_raise(ArgumentError) { my_color.red 0,1 }
		  
			my_line =MyLine .new
			
			# Before setting a value
			assert_nil my_line.color

			# Setting a value - regular or generalized setter
			my_line.width=1; assert_equal 1, my_line.width
			my_line.width 2; assert_equal 2, my_line.width
			
			# Regular and generalized setter return the (new) value
			assert_equal 3, (my_line.width=3)
			assert_equal 4, (my_line.width 4)

			# Modify a value - regular setter, regular getter, block
			my_line.name="hello"      ; assert_equal "hello", my_line.name
      my_line.name.upcase!      ; assert_equal "HELLO", my_line.name
			my_line.name { downcase! }; assert_equal "hello", my_line.name
			  
      # Assign a value
      my_line.color MyColor.new(0, 127, 255)
      assert_equal MyColor, my_line.color.class
      assert_equal [0, 127, 255], my_line.color.to_a
      
      # Generalized create a value (single argument)
      my_line.color "#007fff"
      assert_equal MyColor, my_line.color.class
      assert_equal [0, 127, 255], my_line.color.to_a

      # Generalized create a value (multiple arguments)
      my_line.color 0, 127, 255
      assert_equal MyColor, my_line.color.class
      assert_equal [0, 127, 255], my_line.color.to_a
      
      # For an attribute without a default class, multiple parameters are not
      # allowed
      assert_raise(ArgumentError) { my_line.width 2, 3 }

      # A class with an attribute of the same name - it must not have a default
      # class
      my_other=MyOther.new
      assert_nothing_raised       { my_other.color 0 }
      assert_raise(ArgumentError) { my_other.color 1,2,3 }
		end
	end
end

