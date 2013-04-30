#!/usr/bin/env ruby

require 'test/unit'

require_relative "../lib/zofo_plot"

module ZofoPlot
    class StringExtensionsTest <Test::Unit::TestCase
        def test_to_gnuplot
            sq="'"
            dq='"'
            bs='\\'
            
            # Empty string is wrapped in quotes
            assert_equal '""', "".to_gnuplot
        end
    end
end
