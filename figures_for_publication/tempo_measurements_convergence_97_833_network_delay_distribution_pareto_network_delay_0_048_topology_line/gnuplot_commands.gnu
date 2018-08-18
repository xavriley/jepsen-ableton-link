
  # set terminal pngcairo enhanced font "Helvetica,12.0" size 6400,800;
  # set output "plot.png"
  set terminal pdf size 29.7cm,21cm enhanced color font 'Helvetica'
  set output "plot.pdf"

  set autoscale x
  set lmargin 15 # accomodate different width ytics

  set multiplot layout 2, 1

  set title "Tempo measurements - convergence 97.833% - :network-delay-distribution pareto - :network-delay 0.048 - :topology line"

  set style rect fc lt -1 fs solid 0.15 noborder
  
      set obj rect       from 22.0905592, graph 0       to   59.7370408, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 99.3423235, graph 0       to   138.3789614, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 177.35137500000002, graph 0       to   214.8376001, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    

  
      set obj rect       from 0.0092569999396801, graph 0       to   8.000060999998823, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 30.000279000028968, graph 0       to   30.500879999948665, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 36.06907899992075, graph 0       to   36.97300300002098, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 76.03300599998329, graph 0       to   76.83096499997191, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 94.0508259999333, graph 0       to   94.46902499999851, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 180.0965670000296, graph 0       to   182.37901899998542, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    

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
  

$data_nlgjukgzila_ << NLGJUKGZILA_
1.935207000002265	0.008425	n2
62.29416199994739	0.008424	n2
92.11557499994524	0.008421	n2
152.5637080000015	0.008424	n2

3.91912700003013	0.008414	n3
34.21736200002488	0.008422	n3
63.7757429999765	0.008422	n3
93.72831399994902	0.008434	n3
124.18312900001183	0.008417	n3
153.79639599996153	0.008409	n3
184.30119499994908	0.00841	n3
214.25377599999774	0.008409	n3

5.929683999973349	0.008286	n4
36.183513000025414	0.008401	n4
65.70282300002873	0.008413	n4
95.68448199995328	0.008424	n4
124.98836399998982	0.008409	n4
156.02199699997436	0.008424	n4
186.4246469999198	0.008404	n4
215.79268199997023	0.008427	n4

8.002748999977484	0.008415	n5
37.76218999992125	0.008433	n5
68.00853999995161	0.008413	n5
97.77058699994814	0.008418	n5
128.20544699998572	0.008392	n5
157.96100799995475	0.008422	n5
188.35957700002473	0.008414	n5
217.33083200000692	0.008422	n5
NLGJUKGZILA_
    

  plot "$data_nlgjukgzila_" using 1:2 ti "session: 6X-RH3-P" with linespoints, \
                    '' using 1:2:3 ti "" with labels offset 1, char 1
  

  unset multiplot
