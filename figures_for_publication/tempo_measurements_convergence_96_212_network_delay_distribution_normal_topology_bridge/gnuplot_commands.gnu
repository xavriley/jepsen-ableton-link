
  # set terminal pngcairo enhanced font "Helvetica,12.0" size 6400,800;
  # set output "plot.png"
  set terminal pdf size 29.7cm,21cm enhanced color font 'Helvetica'
  set output "plot.pdf"

  set autoscale x
  set lmargin 15 # accomodate different width ytics

  set multiplot layout 2, 1

  set title "Tempo measurements - convergence 96.212% - :network-delay-distribution normal - :topology bridge"

  set style rect fc lt -1 fs solid 0.15 noborder
  
      set obj rect       from 51.914622900000005, graph 0       to   89.0905238, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 126.34660960000001, graph 0       to   163.47156840000002, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 200.72723100000002, graph 0       to   237.9031319, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    

  
      set obj rect       from 0.008459000033326447, graph 0       to   8.501156000071205, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 53.908388999989256, graph 0       to   54.23584800004028, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 63.90574200008996, graph 0       to   65.66025900002569, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 87.96281300007831, graph 0       to   88.60316900000907, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 111.91645300004166, graph 0       to   112.75833099999, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 135.9737680000253, graph 0       to   137.75652699999046, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 142.093067000038, graph 0       to   142.5832030000165, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 161.93861300009303, graph 0       to   162.7864300000947, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 171.9988660000963, graph 0       to   172.77628200000618, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 183.95629800006282, graph 0       to   184.5036090000067, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    

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
  

$data_ss8tkdu7sek_ << SS8TKDU7SEK_
2.0146820000372827	0.007792	n2
31.898494000080973	0.007748	n2
61.84490000002552	0.007748	n2
91.94563700002618	0.007758	n2
120.56857000000309	0.007748	n2
151.96304400009103	0.007754	n2
182.22667200001888	0.007744	n2
212.17856999998912	0.007753	n2

4.065224000019953	0.00777	n3
34.06828500004485	0.007756	n3
64.08129800006282	0.007754	n3
93.94581500010099	0.007757	n3
123.81232300004922	0.007753	n3
154.20704700006172	0.007747	n3
214.33895000000484	0.007746	n3

6.079331000102684	0.007773	n4
36.025613000034355	0.007748	n4
65.66025900002569	0.007745	n4
94.50057200004812	0.007754	n4
126.17023200006224	0.007746	n4
156.01642700005323	0.00775	n4
186.1702140000416	0.007754	n4
216.06519200000912	0.007778	n4

8.101448000059463	0.007782	n5
37.791342000011355	0.007748	n5
68.07690300000831	0.007743	n5
98.2471310000401	0.007753	n5
158.45524600008503	0.007749	n5
188.60664100002032	0.007767	n5
218.65499599999748	0.00779	n5
SS8TKDU7SEK_
    

  plot "$data_ss8tkdu7sek_" using 1:2 ti "session: I-5-HI" with linespoints, \
                    '' using 1:2:3 ti "" with labels offset 1, char 1
  

  unset multiplot
