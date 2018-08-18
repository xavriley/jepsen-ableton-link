
  # set terminal pngcairo enhanced font "Helvetica,12.0" size 6400,800;
  # set output "plot.png"
  set terminal pdf size 29.7cm,21cm enhanced color font 'Helvetica'
  set output "plot.pdf"

  set autoscale x
  set lmargin 15 # accomodate different width ytics

  set multiplot layout 2, 1

  set title "Tempo measurements - convergence 97.792% - :network-delay-distribution normal - :topology connected"

  set style rect fc lt -1 fs solid 0.15 noborder
  
      set obj rect       from 51.723353800000005, graph 0       to   88.7438614, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 125.7517634, graph 0       to   162.7624447, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 199.7659672, graph 0       to   236.7864748, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    

  
      set obj rect       from 0.005231000017374754, graph 0       to   8.00351600011345, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 57.791370000108145, graph 0       to   58.52631800004747, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 105.7679290000815, graph 0       to   106.43816800008062, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 107.76958000008017, graph 0       to   108.54689100000542, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 129.85932500008494, graph 0       to   130.1653660000302, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 131.8431340000825, graph 0       to   132.10990200005472, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 165.89381500007585, graph 0       to   167.08155400003307, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 173.88945500005502, graph 0       to   174.59279700007755, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    

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
  

$data_ycjmqzl5uwm_ << YCJMQZL5UWM_
2.0072730000829324	0.005171	n2
31.87848000007216	0.00516	n2
61.80153400008567	0.005171	n2
91.10138100001495	0.005187	n2
122.00433900009375	0.00516	n2
152.15945600008126	0.005162	n2
181.8698710000608	0.005177	n2
211.9009500000393	0.005181	n2

3.995272000087425	0.005172	n3
33.86023000010755	0.00516	n3
63.94489400007296	0.00516	n3
93.2837030000519	0.005177	n3
124.08954300009646	0.00516	n3
154.04451900010463	0.00516	n3
184.2155849999981	0.005161	n3
214.08377700007986	0.005145	n3

5.987648000009358	0.005183	n4
35.87620100006461	0.00518	n4
65.17563300009351	0.005172	n4
95.94287200004328	0.005177	n4
125.98491800006013	0.005171	n4
156.0590370000573	0.005156	n4
186.12957200000528	0.005157	n4
216.26581300003454	0.005158	n4

8.070594000048004	0.005183	n5
38.06237100006547	0.005147	n5
68.02823600010015	0.005152	n5
97.90190200007055	0.005182	n5
128.02378000004683	0.005135	n5
158.04860500001814	0.005176	n5
188.30206700006966	0.00516	n5
217.35635200003162	0.005144	n5
YCJMQZL5UWM_
    

  plot "$data_ycjmqzl5uwm_" using 1:2 ti "session: -fC9yQc" with linespoints, \
                    '' using 1:2:3 ti "" with labels offset 1, char 1
  

  unset multiplot
