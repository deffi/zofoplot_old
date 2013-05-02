#!/usr/bin/env ruby

require 'test/unit'

require_relative "../lib/zofo_plot"

module ZofoPlot
    class ElementTest <Test::Unit::TestCase
        class MyElement
            include Element

            attr_accessor :foo, :bar
        end

        def test_attributes
            element_test=self

            my_element=MyElement.create {
                # FIXME why can't we use "foo=1" here?
                self.foo=1
                @bar=2

                element_test.assert_equal 1, self.foo
                element_test.assert_equal 2, self.bar
                element_test.assert_equal 1, foo
                element_test.assert_equal 2, bar
            }

            assert_equal 1, my_element.foo
            assert_equal 2, my_element.bar
        end
    end
end

