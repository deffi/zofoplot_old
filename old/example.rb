#!/usr/bin/env ruby
# Encoding: utf-8

require 'pathname'

require_relative 'lib/zofo_plot'

degree=Math::PI/180

include ZofoPlot

quadratic_points=(0..5).map { |x| DefaultPoint.new(x, x**2) }
quadratic_points[4].y_range=[13, 17]
linear_points=(0..5).map { |x| DefaultPoint.new(x, 5*x) }

lines_chart=Chart.create {
    title "Some chart"
    x_axis { range [-0.5, 5.5] ; label "All right"; tics { visible true; mirror false } }
    y_axis { range [0, 35]     ; label "Updog"    ; tics { visible true; mirror false } }
    #border { none }
        
    data_sets.add {
        title "Linear"
        points linear_points
        line_style  { color "#7fff00"; width 2  }
        point_style { color "#7f00ff"; shape :filled_triangle_down }
    }

    data_sets.add {
        title "Quadratic"
        points      quadratic_points
        line_style  { color "#ff7f00"; width 1  }
        point_style { color "#7f00ff"; shape :filled_triangle_up }
    }

    data_sets.add {
        points [[1,5], [3,5], [5,5]].map { |x,y| DefaultPoint.new(x,y) }
        point_style { shape :open_diamond }
    }
}

hexagon_points=(0..6).map { |i|
    alpha=i/6.0*2*Math::PI
    DefaultPoint.new(2*Math::cos(alpha)+2, 2*Math::sin(alpha)+2)
}

hexagon_data_set=DataSet.create {
    points hexagon_points
    line_style { color "#007fff" }
    point_style { shape :none }
}

hexagon_chart=Chart.create {
    y_axis {
        logarithmic
        format exponential
    }
    border {
        color 127
    }
    data_sets << hexagon_data_set
}

#chart=Chart.create {
#	x_range [0,5]
#	y_range [0,5]
#	data_sets << DataSet.create {
#		points [[0,5], [2,3], [6,0]]
#		line_style { color "#7f7f7f" }
#		point_style { shape :none }
#	}
#}

multi_chart=MultiChart.create {
    charts << lines_chart << hexagon_chart
}

p_chart=Chart.create {
    x_axis { range [0,6] }
    y_axis { range [0, 30] }
    
    title "{/Verdana=36 ABCDEF abcdef}"
    #title "ABCDEF abcdef"
        
    data_sets.add {
        points [[1,1],[2,4],[3,9],[4,16],[5,25]].map { |x,y| DefaultPoint.new(x,y) }
        point_style { color "red"; shape :filled_square; size 1 }
        line_style { color "red"; width 3 }
        title "ABCDEF"
    }
    data_sets.add {
        points [[1,1],[2,2],[3,3],[4,4],[5,5]].map { |x,y| DefaultPoint.new(x,y) }
        point_style { color "blue"; shape :filled_diamond; size 1 }
        line_style { color "blue"; width 3 }
        title "abcdef"
    }
}

outputs=[
    #[p_chart , Pathname.pwd+"example_plots"+"p_zofo.pdf", [12/2.54, 8/2.54]],
    [p_chart , Pathname.pwd+"example_plots"+"p_zofo.png", [900, 600]]
#    [lines_chart  , Pathname.pwd+"example_plots"+"zofo_lines.png"     , [1024, 768]],
#    #	[hexagon_chart, Pathname.pwd+"example_plots"+"zofo_hexagon.png"   , [1024, 768]],
#    [multi_chart  , Pathname.pwd+"example_plots"+"png_small.png"      , [1024, 768]],
#    #	[multi_chart  , Pathname.pwd+"example_plots"+"png_large.png"      , [2048, 1536]],
#    #	[multi_chart  , Pathname.pwd+"example_plots"+"svg_small.svg"      , [1024, 768]],
#    #	[multi_chart  , Pathname.pwd+"example_plots"+"svg_large.svg"      , [2048, 1536]],
#    #	[multi_chart  , Pathname.pwd+"example_plots"+"emf_small.emf"      , [1024, 768]],
#    #	[multi_chart  , Pathname.pwd+"example_plots"+"emf_large.emf"      , [2048, 1536]],
#    #	[multi_chart  , Pathname.pwd+"example_plots"+"pdf_small.pdf"      , [8, 6]],
#    [multi_chart  , Pathname.pwd+"example_plots"+"pdf_large.pdf"      , [16, 12]],
]

Engine.new { |engine|
    outputs.each { |chart, file, size|
        file.unlink if file.exist?
        file.parent.mkpath
        engine.render chart, file, size
    }
}

#file=Pathname.pwd+"example_plots"+"zofo_lines.png"
#file=Pathname.pwd+"example_plots"+"png_small.png"
file=Pathname.pwd+"example_plots"+"p_zofo.png"
if file.exist?
    Kernel.system "start #{file}"
else
    puts "#{file} does not exist."
end

