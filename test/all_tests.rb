#!/usr/bin/env ruby

Dir["#{File.dirname(File.expand_path(__FILE__))}/**/*_test.rb"].sort.each { |entry|
	require entry
}

# at_axit, the AutoRunner will be invoked

