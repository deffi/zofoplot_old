zofoplot
========

A fully scriptable, non-interactive plotting tool

Note that this is work in progress and probably not useful to anyone at the moment.


Goal
====

The goal is to be able to create charts like this:

```ruby
squares_chart=Chart.create {
  title "Squares!"
  x_axis { range 0,5 ; title "n"   }
  y_axis { range 0,25; title "n^2" }

  data_sets.add {
    x [0, 1, 2, 3,  4,  5]
    y [0, 1, 4, 9, 16, 25]

    lines  { color "#7f7f7f"; width 2 }
    points { shape :square; size 5 }
  }
}
    
my_chart.render "squares_chart.png"  # For quickly viewing
my_chart.render "squares_chart.eps"  # For LaTeX
my_chart.render "squares_chart.pdf"  # For pdfLaTeX
my_chart.render "squares_chart.emf"  # For Microsoft Office
my_chart.render "squares_chart.svg"  # For the web
```

Why is that useful? For example, it allows us to create a large number of graphs using a common point size:

```ruby
my_point_size = 5
    
first_chart=Chart.create {
  # ...
  data_sets.add {
    # ...
    points { shape :square; size my_point_size }
  }
  # Many more data sets
}

# Many more charts
```

If we later decide to change the point size, we can just update the value and recreate all
charts automatically. In most interactive plotting tools like Excel or OpenOffice, we would
have to update all data sets of all charts manually.