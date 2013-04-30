#!/usr/bin/env ruby

require 'test/unit'

require_relative "../lib/zofo_plot"

module ZofoPlot
	class ContainerTest <Test::Unit::TestCase
		class MyColor
		    include ZofoPlot::Container
		    
		    zofo_attributes :red, :green, :blue
		end
		
		class MyLine
		    include ZofoPlot::Container
		    
		    zofo_attributes :width, :name, :color
		end
		
		def test_attributes
			my_line =MyLine .new

			# Before setting a value
			assert_nil my_line.color

			# Setting a value - regular setter or generalized setter
			my_line.width=1; assert_equal 1, my_line.width
			my_line.width 2; assert_equal 2, my_line.width

			# Modify a value - regular setter, regular getter, block
			my_line.name="hello"      ; assert_equal "hello", my_line.name
            my_line.name.upcase!      ; assert_equal "HELLO", my_line.name
			my_line.name { downcase! }; assert_equal "hello", my_line.name
		end
	end
end

