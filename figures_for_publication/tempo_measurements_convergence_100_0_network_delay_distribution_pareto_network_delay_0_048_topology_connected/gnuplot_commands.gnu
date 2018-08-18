
  # set terminal pngcairo enhanced font "Helvetica,12.0" size 6400,800;
  # set output "plot.png"
  set terminal pdf size 29.7cm,21cm enhanced color font 'Helvetica'
  set output "plot.pdf"

  set autoscale x
  set lmargin 15 # accomodate different width ytics

  set multiplot layout 2, 1

  set title "Tempo measurements - convergence 100.0% - :network-delay-distribution pareto - :network-delay 0.048 - :topology connected"

  set style rect fc lt -1 fs solid 0.15 noborder
  
      set obj rect       from 22.0412849, graph 0       to   59.639504300000006, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 96.6427476, graph 0       to   134.1678558, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 171.1716762, graph 0       to   208.6886503, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    

  
      set obj rect       from 0.007662000018171966, graph 0       to   9.00038699992001, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    

  set xrange [] writeback
  set xlabel 'Time (seconds)'
  set ylabel 'Tempo (bpm)'

  set yrange [0:220]
  set ytics nomirror

  # Set linestyle 1 to blue (#0060ad)
  set style line 1       linecolor rgb '#770060ad'       linetype 1 linewidth 0.5       pointtype 7 pointsize 0.5

  set style line 2  lc rgb '#770025ad' lt 1 lw 0.5 pt 2 ps 0.5# --- blue
  set style line 3  lc rgb '#770042ad' lt 1 lw 0.5 pt 3 ps 0.5#      .
  set style line 4  lc rgb '#770060ad' lt 1 lw 0.5 pt 4 ps 0.5#      .
  set style line 5  lc rgb '#77007cad' lt 1 lw 0.5 pt 5 ps 0.5#      .
  set style line 6  lc rgb '#770099ad' lt 1 lw 0.5 pt 6 ps 0.5#      .
  set style line 7  lc rgb '#7700ada4' lt 1 lw 0.5 pt 7 ps 0.5#      .
  set style line 8  lc rgb '#7700ad88' lt 1 lw 0.5 pt 8 ps 0.5#      .
  set style line 9  lc rgb '#7700ad6b' lt 1 lw 0.5 pt 9 ps 0.5#      .
  set style line 10 lc rgb '#7700ad4e' lt 1 lw 0.5 pt 10 ps 0.5#      .
  set style line 11 lc rgb '#7700ad31' lt 1 lw 0.5 pt 11 ps 0.5#      .
  set style line 12 lc rgb '#7700ad14' lt 1 lw 0.5 pt 12 ps 0.5#      .
  set style line 13 lc rgb '#7709ad00' lt 1 lw 0.5 pt 13 ps 0.5# --- green

  # plot for [n=1:5] 'plot_data.dat' with lines linestyle n
  plot 'plot_data.dat' index 0 title 'n1' with linespoints linestyle 1,      ''                index 1 title 'n2' with linespoints linestyle 4,      ''                index 2 title 'n3' with linespoints linestyle 7,      ''                index 3 title 'n4' with linespoints linestyle 10,      ''                index 4 title 'n5' with linespoints linestyle 13

  #
  set title "Clock offsets per Link session"

  set key
  set xrange restore
  set ytics
  # set logscale y
  # set format y "10^{%L}
  unset yrange
  set ylabel "Clock offset - seconds"
  

$data_lhgil1ula28_ << LHGIL1ULA28_
2.0334319999674335	0.006968	n2
92.10473599995021	0.006958	n2
122.03843499999493	0.006913	n2
152.01396000001114	0.006955	n2
182.41706300002988	0.006962	n2
212.26077199995052	0.006946	n2

4.053544000023976	0.006984	n3
34.16679899999872	0.006955	n3
63.90237599995453	0.006941	n3
93.81990999996196	0.006949	n3
124.50479899998754	0.006965	n3
154.1593560000183	0.006947	n3
184.5590529999463	0.006939	n3
213.88235700002406	0.006955	n3

36.22541299997829	0.006938	n4
65.96818999992684	0.006971	n4
95.82165699999314	0.006946	n4
126.36161499994341	0.006941	n4
156.03391200001352	0.006956	n4
186.4330159999663	0.006932	n4
215.50444599997718	0.006953	n4

8.357403000001796	0.007002	n5
38.15898199996445	0.006918	n5
67.44841599999927	0.006947	n5
98.29975999996532	0.006945	n5
128.70085999998264	0.006945	n5
158.22892599995248	0.006956	n5
188.633405999979	0.006942	n5
217.1263630000176	0.006967	n5
LHGIL1ULA28_
    

  plot "$data_lhgil1ula28_" using 1:2 ti "session: -x-U-ko" with linespoints, \
                    '' using 1:2:3 ti "" with labels offset 1, char 1
  

  unset multiplot
