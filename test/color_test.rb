#!/usr/bin/env ruby

require 'test/unit'

require_relative "../lib/zofo_plot"

module ZofoPlot
    class ColorTest <Test::Unit::TestCase
        def test_creation
            #   * RGB as individual parameters:    Color.new(0, 127, 255)
            #   * RGB as array:                    Color.new([0, 127, 255])
            #   * HTML notation:                   Color.new("#007fff")
            #   * HTML notation without hash sign: Color.new("007fff")

            # Valid
            assert_equal [0, 127, 255], Color.new(0, 127, 255).to_a
            assert_equal [0, 127, 255], Color.new([0, 127, 255]).to_a
            assert_equal [0, 127, 255], Color.new("#007fff").to_a
            assert_equal [0, 127, 255], Color.new("007fff").to_a

            # Invalid
            assert_raise(ArgumentError) { Color.new("") }
            assert_raise(ArgumentError) { Color.new("...") }
            assert_raise(ArgumentError) { Color.new([])  }
            assert_raise(ArgumentError) { Color.new(0, 127, 255, 255) }

            # Gnuplot
            assert_equal "rgb '#007fff'", Color.new(0, 127, 255).to_gnuplot
        end
    end
end
