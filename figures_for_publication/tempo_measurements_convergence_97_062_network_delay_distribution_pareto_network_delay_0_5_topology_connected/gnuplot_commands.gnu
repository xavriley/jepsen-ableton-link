
  # set terminal pngcairo enhanced font "Helvetica,12.0" size 6400,800;
  # set output "plot.png"
  set terminal pdf size 29.7cm,21cm enhanced color font 'Helvetica'
  set output "plot.pdf"

  set autoscale x
  set lmargin 15 # accomodate different width ytics

  set multiplot layout 2, 1

  set title "Tempo measurements - convergence 97.062% - :network-delay-distribution pareto - :network-delay 0.5 - :topology connected"

  set style rect fc lt -1 fs solid 0.15 noborder
  
      set obj rect       from 21.8057088, graph 0       to   62.6476423, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 99.6545411, graph 0       to   139.9975158, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 177.0001623, graph 0       to   218.7528292, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    

  
      set obj rect       from 0.0053659999975934625, graph 0       to   9.00072100001853, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 71.8599520000862, graph 0       to   73.60660100006498, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 83.84249800001271, graph 0       to   84.87108399998397, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 95.83643000002485, graph 0       to   96.71192800009158, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 117.86168199998792, graph 0       to   118.4692760000471, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 155.96119100006763, graph 0       to   157.71740600001067, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 183.96822000003885, graph 0       to   184.7381180000957, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    

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
  

$data_aggtjzbqz0a_ << AGGTJZBQZ0A_
2.0144510000245646	0.005315	n2
62.01152900001034	0.005299	n2
91.65235200000461	0.005303	n2
151.79199900000822	0.005293	n2

3.9986079999944195	0.005294	n3
64.42095200007316	0.005293	n3
94.39701900002547	0.00529	n3
154.3822700000601	0.005314	n3

6.0256000000517815	0.005366	n4
66.33348800009117	0.005304	n4
96.31741600006353	0.005309	n4
155.96119100006763	0.005318	n4
187.18763500009663	0.005291	n4
216.69622100004926	0.005303	n4

68.56675800005905	0.005303	n5
98.46417500008829	0.005289	n5
158.89460100000724	0.005302	n5
219.27671800006647	0.005295	n5
AGGTJZBQZ0A_
    

  plot "$data_aggtjzbqz0a_" using 1:2 ti "session: hh-0Pg-" with linespoints, \
                    '' using 1:2:3 ti "" with labels offset 1, char 1
  

  unset multiplot
