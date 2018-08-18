
  # set terminal pngcairo enhanced font "Helvetica,12.0" size 6400,800;
  # set output "plot.png"
  set terminal pdf size 29.7cm,21cm enhanced color font 'Helvetica'
  set output "plot.pdf"

  set autoscale x
  set lmargin 15 # accomodate different width ytics

  set multiplot layout 2, 1

  set title "Tempo measurements - convergence 98.644% - :network-delay-distribution normal - :topology connected"

  set style rect fc lt -1 fs solid 0.15 noborder
  
      set obj rect       from 51.6858384, graph 0       to   88.7019489, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 125.7052745, graph 0       to   162.7174462, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 199.72427180000003, graph 0       to   236.74038230000002, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    

  
      set obj rect       from 0.0068240000400692225, graph 0       to   8.500658000004478, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 27.50053299998399, graph 0       to   29.07375400001183, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 53.47320100001525, graph 0       to   54.11158000002615, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 161.2991420000326, graph 0       to   161.5833809999749, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 185.590622000047, graph 0       to   185.94473300001118, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    

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
  

$data_dtdxj3tzdww_ << DTDXJ3TZDWW_
1.8151099999668077	0.006146	n2
31.872545000049286	0.006146	n2
61.58838400000241	0.006146	n2
91.62001299997792	0.00616	n2
121.78364599996712	0.006141	n2
150.8681959999958	0.006166	n2
181.77319099998567	0.006165	n2
211.88881000003312	0.00615	n2

33.531895000021905	0.00616	n3
63.54810200002976	0.006146	n3
93.62403099995572	0.006141	n3
123.83448099996895	0.006147	n3
152.74308899999596	0.006134	n3
183.82681100000627	0.006149	n3
213.81292000005487	0.006134	n3

5.844816999975592	0.006161	n4
34.17389600002207	0.006138	n4
65.71559599996544	0.00616	n4
95.93084899999667	0.006141	n4
125.94280199997593	0.006141	n4
155.55362999998033	0.006146	n4
185.9620860000141	0.006151	n4
216.05968599999323	0.006166	n4

7.86036100005731	0.006235	n5
37.14953599998262	0.00616	n5
67.91905499994755	0.00616	n5
97.59559299994726	0.006139	n5
127.9981469999766	0.006147	n5
157.91500599996652	0.006129	n5
187.81433900003321	0.006166	n5
217.98470200004522	0.006139	n5
DTDXJ3TZDWW_
    

  plot "$data_dtdxj3tzdww_" using 1:2 ti "session: u7W-sul" with linespoints, \
                    '' using 1:2:3 ti "" with labels offset 1, char 1
  

  unset multiplot
