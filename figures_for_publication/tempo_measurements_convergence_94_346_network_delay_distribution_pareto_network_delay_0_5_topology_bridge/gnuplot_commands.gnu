
  # set terminal pngcairo enhanced font "Helvetica,12.0" size 6400,800;
  # set output "plot.png"
  set terminal pdf size 29.7cm,21cm enhanced color font 'Helvetica'
  set output "plot.pdf"

  set autoscale x
  set lmargin 15 # accomodate different width ytics

  set multiplot layout 2, 1

  set title "Tempo measurements - convergence 94.346% - :network-delay-distribution pareto - :network-delay 0.5 - :topology bridge"

  set style rect fc lt -1 fs solid 0.15 noborder
  
      set obj rect       from 22.3308915, graph 0       to   61.157698800000006, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 101.65653520000001, graph 0       to   140.26949090000002, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 181.4344565, graph 0       to   220.26126380000002, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    

  
      set obj rect       from 0.005474000005051494, graph 0       to   9.0004070000723, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 30.497549999970943, graph 0       to   30.953447000007145, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 34.651076999958605, graph 0       to   35.02177600003779, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 40.87562700000126, graph 0       to   41.87758099997882, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 47.224540999974124, graph 0       to   47.861231000046246, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 48.839351000031456, graph 0       to   49.12010499997996, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 55.21810399997048, graph 0       to   56.16475600004196, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 58.81058300007135, graph 0       to   59.966191000072286, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 61.11924899998121, graph 0       to   62.507653999957256, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 66.92804799997248, graph 0       to   67.66858900000807, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 88.98254200001247, graph 0       to   89.40930299996398, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 133.4393449999625, graph 0       to   134.01373300002888, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 149.1438189999899, graph 0       to   149.75531000003684, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 169.17457000003196, graph 0       to   169.86863899999298, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 181.1708440000657, graph 0       to   182.5263940000441, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 191.24936700006947, graph 0       to   191.91205599997193, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 193.29148999997415, graph 0       to   193.60509199998342, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    

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
  

$data_v0e2d3durfy_ << V0E2D3DURFY_
1.9872929999837652	0.005415	n2
92.82375300000422	0.005402	n2
153.05299900006503	0.005407	n2

34.240892000030726	0.005406	n3
63.98872600006871	0.0054	n3
93.98893900006078	0.005397	n3
154.26860199996736	0.005414	n3

6.023401999962516	0.005492	n4
66.0695340000093	0.005396	n4
96.22429100004956	0.005399	n4
156.6379710000474	0.00539	n4

68.41863199998625	0.0054	n5
97.69583900005091	0.005403	n5
158.88739499996882	0.005391	n5
V0E2D3DURFY_
    

  plot "$data_v0e2d3durfy_" using 1:2 ti "session: WA6wwnDV" with linespoints, \
                    '' using 1:2:3 ti "" with labels offset 1, char 1
  

  unset multiplot
