
  # set terminal pngcairo enhanced font "Helvetica,12.0" size 6400,800;
  # set output "plot.png"
  set terminal pdf size 29.7cm,21cm enhanced color font 'Helvetica'
  set output "plot.pdf"

  set autoscale x
  set lmargin 15 # accomodate different width ytics

  set multiplot layout 2, 1

  set title "Tempo measurements - convergence 96.942% - :network-delay-distribution normal - :topology line"

  set style rect fc lt -1 fs solid 0.15 noborder
  
      set obj rect       from 53.012873500000005, graph 0       to   90.17298740000001, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 127.4438288, graph 0       to   164.5652355, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 201.80195930000002, graph 0       to   238.96207320000002, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    

  
      set obj rect       from 0.007243999978527427, graph 0       to   8.000272999983281, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 58.009614999988116, graph 0       to   58.48017599992454, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 72.05032599996775, graph 0       to   72.32504799996968, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 96.03126099996734, graph 0       to   97.0768720000051, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 102.01186299999245, graph 0       to   102.3288669999456, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 108.02070799993817, graph 0       to   108.82051699992735, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 114.00892900000326, graph 0       to   114.95009499997832, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 132.07713400002103, graph 0       to   132.3555349999806, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 136.03466899995692, graph 0       to   137.0739439999452, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 138.0747669999255, graph 0       to   139.0547179999994, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 142.10632599995006, graph 0       to   142.44483499997295, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    

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
  

$data_qi1eq2fjol4_ << QI1EQ2FJOL4_
1.9525519999442622	0.007145	n2
31.99993499997072	0.00713	n2
91.27659299992956	0.007117	n2
122.14210599998478	0.007119	n2
182.75053800002206	0.007115	n2

3.960579999955371	0.00714	n3
33.8165919999592	0.007126	n3
63.86513199994806	0.00714	n3
93.49895799998194	0.00712	n3
153.42036099999677	0.007116	n3
183.8825609999476	0.007145	n3
213.99440999992657	0.007121	n3

6.064950999920256	0.00713	n4
35.88940400001593	0.007128	n4
65.30898999993224	0.007127	n4
96.03126099996734	0.007127	n4
126.2101590000093	0.00714	n4
155.4521470000036	0.007121	n4
185.78037900000345	0.007117	n4
216.196305999998	0.007115	n4

8.055686999927275	0.007129	n5
37.96036100003403	0.007126	n5
67.9641169999959	0.007141	n5
98.05974599998444	0.007126	n5
127.8672469999874	0.007144	n5
157.54970400000457	0.007114	n5
188.24956899997778	0.00712	n5
218.12247399997432	0.007121	n5
QI1EQ2FJOL4_
    

  plot "$data_qi1eq2fjol4_" using 1:2 ti "session: B-Cac-" with linespoints, \
                    '' using 1:2:3 ti "" with labels offset 1, char 1
  

  unset multiplot
