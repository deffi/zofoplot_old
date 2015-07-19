import math

class Chart:
    pass

degree = math.pi / 180

quadratic_x = range(5)
quadratic_y = [x**2 for x in quadratic_x]

linear_x = range(5)
linear_y = [5*x for x in linear_x]

hexagon_x = [2 +     math.cos(i / 6 * 2 * math.pi) for i in range(6)]
hexagon_y = [2 + 2 * math.sin(i / 6 * 2 * math.pi) for i in range(6)]

lines_chart = Chart(classes = "lines")
lines_chart.add_scatter(quadratic_x, quadratic_y, classes = "quadratic")
lines_chart.add_scatter(linear_x   , linear_y   , classes = "linear"   )

hexagon_chart = Chart(classes = "hexagon")
hexagon_chart.add_scatter(hexagon_x, hexagon_y)

"""
data_set.line { width=2 }
data_set[linear].line.color = #7fff00
data_set[linear].marker { color = #7f00ff; shape = v; filled = true }
data_set[quadratic] { line { color #ff7f00 } marker { color #7f00ff; shape ^; filled true } }

chart[hexagon] {
    lines { color #007fff }
    markers 
}
"""


# hexagon_data_set=DataSet.create {
#     points hexagon_points
#     line_style { color "#007fff" }
#     point_style { shape :none }
# }
# 
# lines_chart=Chart.create {
#     title "Some chart"
#     x_axis { range [-0.5, 5.5] ; label "All right"; tics {
#         visible true
#     } }
#     y_axis { range [0, 35]     ; label "Updog"; tics {
#         visible true
#     } }
#     data_sets << quadratic_data_set
#     data_sets << linear_data_set
# 
#     data_sets << DataSet.create {
#         points [[1,5], [3,5], [5,5]].map { |x,y| DefaultPoint.new(x,y) }
#         point_style { shape :open_diamond }
#     }
# }
# 
# hexagon_chart=Chart.create {
#     y_axis { logarithmic }
#     data_sets << hexagon_data_set
# }
# 
# #chart=Chart.create {
# #    x_range [0,5]
# #    y_range [0,5]
# #    data_sets << DataSet.create {
# #        points [[0,5], [2,3], [6,0]]
# #        line_style { color "#7f7f7f" }
# #        point_style { shape :none }
# #    }
# #}
# 
# multi_chart=MultiChart.create {
#     charts << lines_chart << hexagon_chart
# }
# 
# 
# 
# outputs=[
#     [lines_chart  , Pathname.pwd+"example_plots"+"zofo_lines.png"     , [1024, 768]],
# #    [hexagon_chart, Pathname.pwd+"example_plots"+"zofo_hexagon.png"   , [1024, 768]],
#     [multi_chart  , Pathname.pwd+"example_plots"+"png_small.png"      , [1024, 768]],
# #    [multi_chart  , Pathname.pwd+"example_plots"+"png_large.png"      , [2048, 1536]],
# #    [multi_chart  , Pathname.pwd+"example_plots"+"svg_small.svg"      , [1024, 768]],
# #    [multi_chart  , Pathname.pwd+"example_plots"+"svg_large.svg"      , [2048, 1536]],
# #    [multi_chart  , Pathname.pwd+"example_plots"+"emf_small.emf"      , [1024, 768]],
# #    [multi_chart  , Pathname.pwd+"example_plots"+"emf_large.emf"      , [2048, 1536]],
# #    [multi_chart  , Pathname.pwd+"example_plots"+"pdf_small.pdf"      , [8, 6]],
#     [multi_chart  , Pathname.pwd+"example_plots"+"pdf_large.pdf"      , [16, 12]]
#     ]
# 
# Engine.new { |engine|
#     outputs.each { |chart, file, size|
#         file.unlink if file.exist?
#         file.parent.mkpath
#         engine.render chart, file, size
#     }
# }
# 
# #file=Pathname.pwd+"example_plots"+"zofo_lines.png"
# file=Pathname.pwd+"example_plots"+"png_small.png"
# if file.exist?
#     Kernel.system "start #{file}"
# else
#     puts "#{file} does not exist."
# end



# Yet another
# 
# import numpy as np
# 
# x = np.arange(-2, 2, 0.2)
# 
# chart = Chart()
# linear    = chart.add_series(x=x, y=x**1, label="Linear"   , classes="odd" )
# quadratic = chart.add_series(x=x, y=x**2, label="Quadratic", classes="even")
# cubic     = chart.add_series(x=x, y=x**3, label="Cubic"    , classes="odd" )
# 
# 
# linear.set_style("marker.area.color", "#ffff00")
# 
# 
# chart.show()
# 
# 
# '''
# series["linear"   ].marker.shape = "o"
# series["quadratic"].marker.shape = "s"
# series["cubic"    ].marker.shape = "d"
# 
# series             .marker.filled = "true"
# series["even"     ].marker.filled = "false"
# 
# '''





