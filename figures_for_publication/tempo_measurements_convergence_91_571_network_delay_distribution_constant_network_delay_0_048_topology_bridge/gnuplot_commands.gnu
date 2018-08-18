
  # set terminal pngcairo enhanced font "Helvetica,12.0" size 6400,800;
  # set output "plot.png"
  set terminal pdf size 29.7cm,21cm enhanced color font 'Helvetica'
  set output "plot.pdf"

  set autoscale x
  set lmargin 15 # accomodate different width ytics

  set multiplot layout 2, 1

  set title "Tempo measurements - convergence 91.571% - :network-delay-distribution constant - :network-delay 0.048 - :topology bridge"

  set style rect fc lt -1 fs solid 0.15 noborder
  
      set obj rect       from 22.0997026, graph 0       to   59.6966953, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 97.3770473, graph 0       to   137.06379230000002, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 174.6704884, graph 0       to   212.21310780000002, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    

  
      set obj rect       from 0.006876999977976084, graph 0       to   9.000393999973312, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 30.059262999915518, graph 0       to   30.72865099995397, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 40.0613589999266, graph 0       to   40.40594199998304, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 45.99073399999179, graph 0       to   46.26864199992269, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 64.06002099998295, graph 0       to   64.64758799993433, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 78.14625999995042, graph 0       to   79.16572499996983, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 100.09037300001364, graph 0       to   100.91813000000548, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 106.09762299992144, graph 0       to   106.92599000001792, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 107.87834900000598, graph 0       to   108.83063400001265, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 112.58363899996039, graph 0       to   114.37561899994034, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 118.29521799995564, graph 0       to   118.6312410000246, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 119.89160199998878, graph 0       to   121.12230299995281, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 124.16566099994816, graph 0       to   125.21519899996929, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 126.2497629999416, graph 0       to   128.2533510000212, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 130.18588799994905, graph 0       to   132.342267, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 136.24514699995052, graph 0       to   137.05047100002412, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 137.8890390000306, graph 0       to   138.16705899999943, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 142.15761899994686, graph 0       to   143.00813600001857, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 150.15851400000975, graph 0       to   150.8145319999894, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 183.89645699993707, graph 0       to   184.87360099994112, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 185.47958199994173, graph 0       to   186.80762699991465, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    

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
  

$data_bimpjls8by8_ << BIMPJLS8BY8_
2.0057259999448434	0.006152	n2
33.363761999993585	-0.017993	n2
59.75949099997524	0.006134	n2
92.0288859999273	0.006146	n2
124.19032699998934	-0.018365	n2
152.08985400001984	0.006146	n2
183.24756499996874	-0.018054	n2
212.48942499991972	0.006127	n2

3.9819140000035986	0.006193	n3
35.49781199998688	-0.018439	n3
64.06002099998295	0.006149	n3
93.87394600000698	0.006137	n3
124.62443899991922	-0.018415	n3
154.00479099992663	0.006133	n3
185.5044619999826	-0.018867	n3
213.91473499999847	0.006141	n3

6.012080000014976	0.006152	n4
38.0786369999405	0.005769	n4
65.76811199996155	0.006133	n4
95.77392399997916	0.006131	n4
126.33871099993121	-0.017629	n4
188.52799299999606	0.006627	n4
216.09468099998776	0.006117	n4

8.12625199998729	0.006156	n5
40.088897999958135	0.006155	n5
67.93865899997763	0.006128	n5
99.32529800001066	-0.01775	n5
128.25403599999845	-0.017605	n5
158.2243539999472	0.006126	n5
219.68676800001413	0.006151	n5
BIMPJLS8BY8_
    

  plot "$data_bimpjls8by8_" using 1:2 ti "session: n-o-" with linespoints, \
                    '' using 1:2:3 ti "" with labels offset 1, char 1
  

  unset multiplot
