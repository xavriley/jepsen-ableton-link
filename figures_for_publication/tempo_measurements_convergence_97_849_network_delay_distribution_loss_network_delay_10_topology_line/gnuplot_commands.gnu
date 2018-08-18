
  # set terminal pngcairo enhanced font "Helvetica,12.0" size 6400,800;
  # set output "plot.png"
  set terminal pdf size 29.7cm,21cm enhanced color font 'Helvetica'
  set output "plot.pdf"

  set autoscale x
  set lmargin 15 # accomodate different width ytics

  set multiplot layout 2, 1

  set title "Tempo measurements - convergence 97.849% - :network-delay-distribution loss - :network-delay 10 - :topology line"

  set style rect fc lt -1 fs solid 0.15 noborder
  
      set obj rect       from 52.0917, graph 0       to   89.5128667, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 126.89078810000001, graph 0       to   164.2636434, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 201.81266250000002, graph 0       to   239.2338292, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    

  
      set obj rect       from 0.007034000009298325, graph 0       to   8.00126900000032, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 60.08421699993778, graph 0       to   60.99307199998293, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 136.26383299997542, graph 0       to   136.95265999995172, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 138.24216999998316, graph 0       to   138.83566799992695, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 145.2847189999884, graph 0       to   145.76834399998188, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 154.29021599993575, graph 0       to   156.40391899994574, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    

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
  

$data_fmjzpt9dc0o_ << FMJZPT9DC0O_
1.982956999912858	0.006075	n2
31.808735999977216	0.006059	n2
92.1110580000095	0.006045	n2
122.28669699991588	0.00603	n2
182.4519619999919	0.006054	n2
212.43237299995963	0.006037	n2

3.995547999977134	0.006038	n3
33.57436899992172	0.006054	n3
63.82734199997503	0.006033	n3
94.06641099997796	0.006059	n3
124.03417299990542	0.006028	n3
153.57466599997133	0.006039	n3
184.14245799998753	0.006057	n3
213.82866299990565	0.006006	n3

35.62244499998633	0.006032	n4
66.004106999957	0.005999	n4
94.71901299990714	0.006043	n4
126.01441499998327	0.006043	n4
155.00272699992638	0.006054	n4
185.87754099990707	0.006032	n4
215.2233239999041	0.006037	n4

8.052653999999166	0.006134	n5
38.11914899991825	0.006035	n5
68.02442799997516	0.006037	n5
98.16455399990082	0.006027	n5
127.36033599998336	0.006037	n5
157.99443699989934	0.006051	n5
187.37352199992165	0.006039	n5
218.01398899999913	0.006037	n5
FMJZPT9DC0O_
    

  plot "$data_fmjzpt9dc0o_" using 1:2 ti "session: -bs-sJ" with linespoints, \
                    '' using 1:2:3 ti "" with labels offset 1, char 1
  

  unset multiplot
