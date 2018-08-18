
  # set terminal pngcairo enhanced font "Helvetica,12.0" size 6400,800;
  # set output "plot.png"
  set terminal pdf size 29.7cm,21cm enhanced color font 'Helvetica'
  set output "plot.pdf"

  set autoscale x
  set lmargin 15 # accomodate different width ytics

  set multiplot layout 2, 1

  set title "Tempo measurements - convergence 97.77% - :network-delay-distribution pareto - :network-delay 0.048 - :topology bridge"

  set style rect fc lt -1 fs solid 0.15 noborder
  
      set obj rect       from 22.1275811, graph 0       to   59.7069678, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 97.17713970000001, graph 0       to   134.6812882, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 174.40347350000002, graph 0       to   213.84878590000002, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    

  
      set obj rect       from 0.006428999942727387, graph 0       to   9.00203699991107, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 48.17030699993484, graph 0       to   49.86288799997419, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 102.25843299995176, graph 0       to   102.57575399999041, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 124.28699299995787, graph 0       to   125.07440299994778, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 168.27289199992083, graph 0       to   169.31329599989112, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 186.5095839999849, graph 0       to   187.68408499995712, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    

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
  

$data_l3enk0julsq_ << L3ENK0JULSQ_
2.0584239999298006	0.00633	n2
32.11553399998229	0.006304	n2
61.86389999999665	0.006317	n2
91.90746199991554	0.006318	n2
152.00321599992458	0.006307	n2
181.19451800000388	0.006311	n2
212.4375529999379	0.006294	n2

4.051592999952845	0.006306	n3
34.305374999996275	0.006293	n3
64.01905799994711	0.006327	n3
93.65420699992683	0.006301	n3
124.28759999992326	0.006311	n3
154.07088899996597	0.006318	n3
183.5955299999332	0.006321	n3
214.27796199999284	0.006331	n3

6.065785999991931	0.006318	n4
36.62006799993105	0.006285	n4
65.6082559999777	0.006315	n4
96.0598839999875	0.006313	n4
126.60662899992894	0.006307	n4
186.71793199994136	0.006317	n4
216.11823499994352	0.006313	n4

8.149930999963544	0.006277	n5
38.39561899995897	0.006286	n5
68.15111899992917	0.006313	n5
129.03335799998604	0.006304	n5
158.46184399991762	0.006331	n5
188.65183099999558	0.006319	n5
218.695638999925	0.006319	n5
L3ENK0JULSQ_
    

  plot "$data_l3enk0julsq_" using 1:2 ti "session: -q-BT-" with linespoints, \
                    '' using 1:2:3 ti "" with labels offset 1, char 1
  

  unset multiplot
