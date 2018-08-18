
  # set terminal pngcairo enhanced font "Helvetica,12.0" size 6400,800;
  # set output "plot.png"
  set terminal pdf size 29.7cm,21cm enhanced color font 'Helvetica'
  set output "plot.pdf"

  set autoscale x
  set lmargin 15 # accomodate different width ytics

  set multiplot layout 2, 1

  set title "Tempo measurements - convergence 95.088% - :network-delay-distribution normal - :network-delay 0.048 - :topology line"

  set style rect fc lt -1 fs solid 0.15 noborder
  
      set obj rect       from 24.5102331, graph 0       to   62.1022114, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 99.7755212, graph 0       to   139.2260685, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 176.9240981, graph 0       to   216.40157620000002, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    

  
      set obj rect       from 0.006397000048309565, graph 0       to   8.00109000003431, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 29.50025700009428, graph 0       to   30.000372000038624, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 31.524657000089064, graph 0       to   31.816715000080876, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 35.50757000001613, graph 0       to   36.85392500006128, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 41.59788800007664, graph 0       to   41.82153600000311, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 59.63451200001873, graph 0       to   61.20933500002138, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 89.48254900006577, graph 0       to   89.97984600008931, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 115.53716000006534, graph 0       to   115.83825600007549, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 131.48272000008728, graph 0       to   132.13468200003263, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 143.50450800010003, graph 0       to   143.80808800004888, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 149.39257500006352, graph 0       to   149.733945999993, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 151.38355000002775, graph 0       to   153.91226600005757, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 156.8965390000958, graph 0       to   157.54211700009182, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 175.1994270000141, graph 0       to   176.0692230000859, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 191.28854199999478, graph 0       to   192.47038499999326, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 236.89088100008667, graph 0       to   336.89088100008667, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    

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
  

$data_v154nk5zrd0_ << V154NK5ZRD0_
1.9568820000858977	0.006357	n2
61.96102500008419	0.006332	n2
92.09003200009465	0.006326	n2
151.41135200008284	0.006326	n2

3.9726469999877736	0.006372	n3
35.20224400004372	-0.020282	n3
63.97289900004398	0.00633	n3
94.01495900005102	0.00633	n3
125.00075000000652	-0.015867	n3
153.9399980000453	0.00634	n3
185.40644600009546	-0.017551	n3
215.25829200004227	-0.021957	n3

5.949224999989383	0.00634	n4
36.88078400003724	-0.017372	n4
65.6081520000007	0.006332	n4
96.05912200000603	0.006329	n4
126.84698700008448	-0.020392	n4
155.6044819999952	0.006321	n4
187.48640900000464	-0.017401	n4
216.12464799999725	0.006318	n4

8.034175000037067	0.00641	n5
39.41229900007602	-0.017831	n5
67.92903400002979	0.00633	n5
97.28301600005943	0.006329	n5
128.89981100009754	-0.01845	n5
157.55133400007617	0.00634	n5
189.39760100003332	-0.017693	n5
218.14281500002835	0.006331	n5
V154NK5ZRD0_
    

  plot "$data_v154nk5zrd0_" using 1:2 ti "session: W-x6NsD-" with linespoints, \
                    '' using 1:2:3 ti "" with labels offset 1, char 1
  

  unset multiplot
