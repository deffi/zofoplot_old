set terminal pdf enhanced color
set output 'test.pdf'
set encoding utf8

plot '-' with points pointtype 7 pointsize variable title '[φ] \261'
1 1 2
2 2 3
3 3 4
e


