require 'tempfile'

module ZofoPlot
    class Engine
        def initialize
            if block_given?
                yield self
                self.commit
            end
        end

        def render(chart, filename, size)
            @file ||= Tempfile.new('zofoplot')

            # Don't write the commands to gnuplot's standard input: this will
            # cause "input data ('e' ends)" to be output for every data point
            # on Windows, which slows down the rendering a lot. Instead, write
            # the commands to a temporary file.

            #puts "Rendering #{filename}"

            width =size[0]
            height=size[1]

            terminal=case filename.to_s
            when nil      then nil
            when /\.png$/ then "pngcairo"
            when /\.svg$/ then "svg"
            when /\.emf$/ then "emf"
            when /\.pdf$/ then "pdfcairo"
            else raise ArgumentError, "Unrecognized file format: #{filename}"
            end

            @file.puts "print 'Rendering #{filename}'"
            @file.puts "set terminal #{terminal} enhanced size #{width},#{height}"
            @file.puts "set output '#{filename}'"
            gnuplot=chart.to_gnuplot
            #puts gnuplot
            @file.puts gnuplot
            #@file.puts "pause 2"
        end

        def commit
            return if @file.nil?

            @file.close
            Kernel.system "gnuplot #{@file.path}"
            @file.unlink
            @file=nil
        end
    end
end

