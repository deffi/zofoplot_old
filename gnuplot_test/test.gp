set encoding utf8

set terminal pdfcairo enhanced color
set output 'test_output.pdf'

set title "A test"
# If we get a plusminus sign in the second [], the input is interpreted as
# latin1, although it should be interpreted as UTF8.
# \261 for latin1 plusminus
plot 'test_data.dat' using 1:2:4 with points pointtype 7 pointsize variable title '[φ] [261]',\
     'test_data.dat' using 1:3:4 with points pointtype 2 pointsize variable

set terminal postscript enhanced color
set output 'test_output.ps'
replot

set terminal postscript eps enhanced color
set output 'test_output.eps'
replot

set terminal pngcairo enhanced color
set output 'test_output.png'
replot

set terminal svg enhanced
set output 'test_output.svg'
replot


