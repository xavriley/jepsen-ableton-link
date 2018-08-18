
  # set terminal pngcairo enhanced font "Helvetica,12.0" size 6400,800;
  # set output "plot.png"
  set terminal pdf size 29.7cm,21cm enhanced color font 'Helvetica'
  set output "plot.pdf"

  set autoscale x
  set lmargin 15 # accomodate different width ytics

  set multiplot layout 2, 1

  set title "Tempo measurements - convergence 89.858% - :network-delay-distribution constant - :network-delay 0.048 - :topology connected"

  set style rect fc lt -1 fs solid 0.15 noborder
  
      set obj rect       from 21.849077800000003, graph 0       to   59.4285897, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 96.4318131, graph 0       to   136.21333800000002, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 173.2216626, graph 0       to   213.1350255, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    

  
      set obj rect       from 0.009053000016137958, graph 0       to   8.500296000041999, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 37.19695200002752, graph 0       to   42.70316799997818, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 57.19107499998063, graph 0       to   59.1048609999707, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 59.73634599999059, graph 0       to   60.73033300007228, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 77.75426499999594, graph 0       to   78.3535860000411, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 111.83163799997419, graph 0       to   112.21632900007535, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 117.86801900004502, graph 0       to   118.37719500006642, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 129.9855240000179, graph 0       to   135.2479830000084, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 137.78578300005756, graph 0       to   142.57227300002705, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 147.49267399997916, graph 0       to   148.5639900000533, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 184.6742240000749, graph 0       to   186.21395000000484, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 189.68109299999196, graph 0       to   190.0256839999929, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 234.39681800000835, graph 0       to   334.39681800000835, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    

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
  

$data_cfteanvtoyk_ << CFTEANVTOYK_
1.9142520000459626	0.008188	n2
91.8468480000738	0.008163	n2
124.09617200004868	-0.016076	n2
152.10009600000922	0.008162	n2
183.1758100000443	-0.016886	n2
212.6709109999938	0.008181	n2

3.9104430000297725	0.008182	n3
63.730876000015996	0.008182	n3
94.02032000001054	0.008182	n3
124.63258400000632	-0.015857	n3
153.93798499996774	0.008182	n3
185.00172599998768	-0.016075	n3
213.945919000078	0.008162	n3

5.898736000061035	0.008249	n4
36.32722199999262	-0.015989	n4
65.97388100007083	0.008172	n4
94.93134900007863	0.008163	n4
126.85162500001024	-0.015867	n4
156.050402999972	0.008163	n4
186.94785900006536	-0.015957	n4
216.18003799999133	0.008176	n4

7.989216000074521	0.0083	n5
39.90802700002678	-0.016144	n5
68.03404800000135	0.008172	n5
129.38010199996643	-0.016228	n5
157.2964080000529	0.008162	n5
189.70593699999154	-0.015896	n5
218.0957669999916	0.008172	n5
CFTEANVTOYK_
    

  plot "$data_cfteanvtoyk_" using 1:2 ti "session: p-Djum-" with linespoints, \
                    '' using 1:2:3 ti "" with labels offset 1, char 1
  

  unset multiplot
