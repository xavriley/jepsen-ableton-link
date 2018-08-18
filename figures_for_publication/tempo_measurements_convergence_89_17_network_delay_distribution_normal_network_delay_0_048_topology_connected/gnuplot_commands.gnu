
  # set terminal pngcairo enhanced font "Helvetica,12.0" size 6400,800;
  # set output "plot.png"
  set terminal pdf size 29.7cm,21cm enhanced color font 'Helvetica'
  set output "plot.pdf"

  set autoscale x
  set lmargin 15 # accomodate different width ytics

  set multiplot layout 2, 1

  set title "Tempo measurements - convergence 89.17% - :network-delay-distribution normal - :network-delay 0.048 - :topology connected"

  set style rect fc lt -1 fs solid 0.15 noborder
  
      set obj rect       from 21.878765, graph 0       to   59.6450461, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 96.64943170000001, graph 0       to   136.86701870000002, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 173.8711983, graph 0       to   214.1423513, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    

  
      set obj rect       from 0.0072619999991729856, graph 0       to   9.001033000065945, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 39.694745999993756, graph 0       to   40.25309600005858, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 45.26928400003817, graph 0       to   47.14432099997066, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 53.970881000044756, graph 0       to   54.861670000012964, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 57.954441000008956, graph 0       to   60.001725999987684, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 63.39775100001134, graph 0       to   63.964090000023134, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 106.02286000002641, graph 0       to   106.65544400003273, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 129.9134619999677, graph 0       to   131.4515919999685, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 133.00102600001264, graph 0       to   138.07454900001176, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 141.95408699999098, graph 0       to   142.93060199997853, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 149.5932380000595, graph 0       to   150.3170730000129, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 155.59145800000988, graph 0       to   158.83014700002968, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 166.0377289999742, graph 0       to   168.6927090000827, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 173.90453900001012, graph 0       to   176.26954700006172, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 185.48744100006297, graph 0       to   186.81760800001211, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    

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
  

$data_dlsqj2ajwzq_ << DLSQJ2AJWZQ_
1.9974850000580773	0.006321	n2
32.78028299997095	-0.017803	n2
61.703041000058874	0.006332	n2
91.95853100006934	0.006333	n2
122.79006400005892	-0.018945	n2
152.1819710000418	0.006322	n2
183.53488400008064	-0.019426	n2
213.59348599996883	-0.018089	n2

35.000551000004634	-0.019063	n3
63.96611999999732	0.006338	n3
93.35315800004173	0.006341	n3
124.96912300004624	-0.016477	n3
153.91662999999244	0.006316	n3
184.5905620000558	-0.018059	n3
214.20353499997873	0.006322	n3

6.001820000004955	0.006341	n4
36.91569900000468	-0.017371	n4
65.64875100005884	0.006332	n4
95.67207900003996	0.006344	n4
127.12669200007804	-0.018003	n4
155.92635800002608	0.006334	n4
187.3848360000411	-0.018591	n4
216.03225200006273	0.006337	n4

8.138052000082098	0.006341	n5
39.16100700001698	-0.021126	n5
67.40511100005824	0.006332	n5
99.53012100001797	-0.017066	n5
129.4468160000397	-0.017484	n5
156.2624520000536	0.006323	n5
189.2305720000295	-0.017094	n5
218.163973000017	0.006321	n5
DLSQJ2AJWZQ_
    

  plot "$data_dlsqj2ajwzq_" using 1:2 ti "session: v-4" with linespoints, \
                    '' using 1:2:3 ti "" with labels offset 1, char 1
  

  unset multiplot
