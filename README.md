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

        lines  { color "#7f7f7f"; width 2 }
        points { shape :square; size 5 }
      }
    }
    
    chard.render "squares.pdf"
    chard.render "squares.png"

Why is that useful? For example, it allows us to create a large number of graphs using a common point size:

    my_point_size = 5
    
    chart=Chart.create {
      # ...
      data_sets.add {
        # ...
        points { shape :square; size my_point_size }
      }
      # ...
    }
    
    # More charts

If we later decide to change the point size, we can just update the value and recreate all
charts automatically. In most interactive plotting tools like Excel or OpenOffice, we would
have to update all points manually.
