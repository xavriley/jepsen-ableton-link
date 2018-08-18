
  # set terminal pngcairo enhanced font "Helvetica,12.0" size 6400,800;
  # set output "plot.png"
  set terminal pdf size 29.7cm,21cm enhanced color font 'Helvetica'
  set output "plot.pdf"

  set autoscale x
  set lmargin 15 # accomodate different width ytics

  set multiplot layout 2, 1

  set title "Tempo measurements - convergence 90.385% - :network-delay-distribution constant - :network-delay 0.048 - :topology line"

  set style rect fc lt -1 fs solid 0.15 noborder
  
      set obj rect       from 22.2380681, graph 0       to   59.8625988, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 97.55662740000001, graph 0       to   135.098908, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 172.7920852, graph 0       to   211.77483510000002, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    

  
      set obj rect       from 0.007123999996110797, graph 0       to   9.00068099994678, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 42.0955069999909, graph 0       to   42.46445299999323, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 51.19713599991519, graph 0       to   52.6725940000033, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 56.897506000008434, graph 0       to   60.10159599990584, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 65.78831500001252, graph 0       to   66.8057549999794, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 96.33047899999656, graph 0       to   97.8397249999689, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 102.29348200000823, graph 0       to   103.66064199991524, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 115.29945299995597, graph 0       to   118.8343669999158, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 125.7747349999845, graph 0       to   127.00059999991208, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 130.26197300001513, graph 0       to   130.75208599993493, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 132.17980299994815, graph 0       to   132.65492799994536, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 137.8945919999387, graph 0       to   138.52722099993844, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 144.19941599993035, graph 0       to   145.06568200001493, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 148.19309399998747, graph 0       to   148.50437599990983, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 162.29089900001418, graph 0       to   163.37288199993782, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 174.41461400000844, graph 0       to   174.80444799992256, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 178.46450599993113, graph 0       to   179.21292600000743, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 184.44468600000255, graph 0       to   187.37404099991545, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    

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
  

$data_zwkzomrfjlq_ << ZWKZOMRFJLQ_
2.1427119999425486	0.006338	n2
62.004527000011876	0.006323	n2
92.11963299999479	0.006331	n2
152.6606309999479	0.006336	n2
213.1041649999097	0.006312	n2

4.0646649999544024	0.006368	n3
33.98514599993359	-0.017708	n3
63.916417000000365	0.006324	n3
94.05499099998269	0.006331	n3
125.80091200000606	-0.018259	n3
154.03782899992075	0.006317	n3
185.07199299999047	-0.01772	n3
214.32105099991895	0.006312	n3

6.004644999979064	0.006349	n4
36.929851999972016	-0.018063	n4
65.78831500001252	0.006322	n4
96.01410399994347	0.006323	n4
127.37393299990799	-0.01875	n4
156.06429100001696	0.006312	n4
187.39979599998333	-0.018194	n4
216.18595499999356	0.006332	n4

8.200502999941818	0.006312	n5
39.75972400000319	-0.017846	n5
67.85005499992985	0.00632	n5
99.09062199993059	-0.017914	n5
129.3887809999287	-0.018321	n5
158.30956299998797	0.006331	n5
189.4095869999146	-0.017889	n5
ZWKZOMRFJLQ_
    

  plot "$data_zwkzomrfjlq_" using 1:2 ti "session: ei3-d-T" with linespoints, \
                    '' using 1:2:3 ti "" with labels offset 1, char 1
  

  unset multiplot
