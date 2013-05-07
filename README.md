zofoplot
========

A fully scriptable, non-interactive plotting tool

Note that this is work in progress and probably not useful to anyone at the moment.

Goal
====

The goal is to be able to create charts like this:

    chart=Chart.create {
      title "Squares"
      x_axis { range 0,5 ; title "n"   }
      y_axis { range 0,25; title "n^2" }

      data_sets.add {
        x [0, 1, 2, 3,  4,  5]
        y [0, 1, 4, 9, 16, 25]

        line_style  { color "#7f7f7f"; width 2 }
        point_style { shape :square; size 5 }
      }
    }
    
    chard.render "squares.pdf"
    chard.render "squares.png"
