#!/usr/bin/env ruby

require 'test/unit'

require_relative "../lib/zofo_plot"

module ZofoPlot
    class ColorTest <Test::Unit::TestCase
        def test_construction
            # Valid creation
            assert_equal [ 0, 127, 255], Color.new(0, 127, 255).to_a
            assert_equal [ 0, 127, 255], Color.new([0, 127, 255]).to_a
            assert_equal [ 0, 127, 255], Color.new("#007fff").to_a
            assert_equal [ 0, 127, 255], Color.new("007fff").to_a
            assert_equal [42,  42,  42], Color.new(42).to_a
            
            # From names
            assert_equal [255, 0, 0], Color.new("red" ) .to_a
            assert_equal [0, 0, 255], Color.new("blue") .to_a
            assert_equal [0, 0, 0]  , Color.new("black").to_a

            # Invalid creation
            assert_raise(ArgumentError) { Color.new("") }
            assert_raise(ArgumentError) { Color.new("...") }
            assert_raise(ArgumentError) { Color.new([])  }
            assert_raise(ArgumentError) { Color.new(0, 127, 255, 255) }
            assert_raise(ArgumentError) { Color.new(-1, 0, 0) }
            assert_raise(ArgumentError) { Color.new(0, 0, 256) }
            assert_raise(ArgumentError) { Color.new([-1, 0, 0]) }
            assert_raise(ArgumentError) { Color.new([0, 0, 256]) }
            assert_raise(ArgumentError) { Color.new(-1) }
            assert_raise(ArgumentError) { Color.new(256) }
        end

        def test_creation
            assert_equal [0, 127, 255], Color.create { red 0; green 127; blue 255 }.to_a
            # We can't do this, why?
            #assert_equal [0, 127, 255], Color.create { red=0; green=127; blue=255 }.to_a
        end
        
        def test_gnuplot
            assert_equal "rgb '#007fff'", Color.new(0, 127, 255).to_gnuplot
        end

        def test_equality
            # Create some colors
            c1a=Color.new(0, 127, 255)
            c1b=Color.new(0, 127, 255)
            c2 =Color.new(255, 127, 0)
            
            # Test for equality
            assert_true  c1a==c1a, "Same color must be =="
            assert_true  c1a==c1b, "Identical colors must be =="
            assert_false c1a==c2 , "Different colors must not be =="
            
            # Test for identity
            assert_true  c1a.equal?(c1a), "Same color must be equal?"
            assert_false c1a.equal?(c1b), "Identical colors must not be equal?"
            assert_false c1a.equal?(c2) , "Different colors must not be equal?"
        end

    end
end
