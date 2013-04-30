#!/usr/bin/env ruby

require 'test/unit'

require_relative "../lib/zofo_plot"

module ZofoPlot
	class ContainerTest <Test::Unit::TestCase
		class MyContainer
			include ZofoPlot::Container
			zofo_attributes :foo, :bar
		end

		def test_attributes
			my_container=MyContainer.new

			# Before setting a value
			assert_nil my_container.foo

			# Set a value in the various ways
			my_container.foo=1; assert_equal 1, my_container.foo
			my_container.foo 2; assert_equal 2, my_container.foo

			# Call a block in the context of the value
			my_container.bar="hello"
			assert_equal "hello", my_container.bar
			my_container.bar { upcase! }
			assert_equal "HELLO", my_container.bar
		end
	end
end

