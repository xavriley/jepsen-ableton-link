
  # set terminal pngcairo enhanced font "Helvetica,12.0" size 6400,800;
  # set output "plot.png"
  set terminal pdf size 29.7cm,21cm enhanced color font 'Helvetica'
  set output "plot.pdf"

  set autoscale x
  set lmargin 15 # accomodate different width ytics

  set multiplot layout 2, 1

  set title "Tempo measurements - convergence 98.054% - :network-delay-distribution loss - :network-delay 50 - :topology line"

  set style rect fc lt -1 fs solid 0.15 noborder
  
      set obj rect       from 52.188230600000004, graph 0       to   100.0895203, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 160.9467769, graph 0       to   212.24332650000002, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    

  
      set obj rect       from 0.005084999953396618, graph 0       to   9.000802999944426, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 52.23851900000591, graph 0       to   52.909023999935016, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 71.32030699995812, graph 0       to   72.73254699993413, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 110.90862699993886, graph 0       to   112.11814999999478, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 170.71929399995133, graph 0       to   171.84951299999375, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    

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
  

$data_yg5va1zfcse_ << YG5VA1ZFCSE_
2.1068209999939427	0.005039	n2
31.935105999931693	0.005038	n2
122.6437160000205	0.005029	n2
152.72152499994263	0.005028	n2

4.012264000019059	0.00504	n3
33.93370399996638	0.005017	n3
123.35314399993513	0.005019	n3
154.70977199997287	0.005029	n3

6.032064999919385	0.005053	n4
35.934980000020005	0.005028	n4
156.82650799991097	0.005013	n4
216.98505899996962	0.005029	n4

8.157465999945998	0.005038	n5
37.37983799993526	0.005014	n5
128.8364719999954	0.005046	n5
159.00351900001988	0.005015	n5
219.05447899992578	0.005023	n5
YG5VA1ZFCSE_
    

  plot "$data_yg5va1zfcse_" using 1:2 ti "session: -nUkVEq-" with linespoints, \
                    '' using 1:2:3 ti "" with labels offset 1, char 1
  

  unset multiplot
