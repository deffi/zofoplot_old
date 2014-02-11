module ZofoPlot
    VERSION = '0.1.0'
end

Dir["#{File.dirname(__FILE__)}/zofo_plot/**/*.rb"].sort.each { |lib|
    require lib
}

