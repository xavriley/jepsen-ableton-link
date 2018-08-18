
  # set terminal pngcairo enhanced font "Helvetica,12.0" size 6400,800;
  # set output "plot.png"
  set terminal pdf size 29.7cm,21cm enhanced color font 'Helvetica'
  set output "plot.pdf"

  set autoscale x
  set lmargin 15 # accomodate different width ytics

  set multiplot layout 2, 1

  set title "Tempo measurements - convergence 93.432% - :network-delay-distribution normal - :network-delay 0.048 - :topology bridge"

  set style rect fc lt -1 fs solid 0.15 noborder
  
      set obj rect       from 22.0865639, graph 0       to   59.713997000000006, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 97.5863504, graph 0       to   137.5815025, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 175.2738653, graph 0       to   215.3125281, graph 1       fillcolor rgb "#000000"       fillstyle transparent solid 0.05       noborder
    

  
      set obj rect       from 0.0070550000527873635, graph 0       to   9.001002999953926, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 35.98002000001725, graph 0       to   36.73792200000025, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 40.279087999952026, graph 0       to   43.6532929999521, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 45.889193000039086, graph 0       to   46.71085300005507, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 48.21076599997468, graph 0       to   49.943452000035904, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 65.69384800002445, graph 0       to   66.45811200002208, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 124.34837999998126, graph 0       to   125.22551899997052, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 126.08329500001855, graph 0       to   126.51090700004715, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 130.16889400000218, graph 0       to   131.95335199998226, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 147.79877700004727, graph 0       to   148.85759499995038, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 150.19173399999272, graph 0       to   150.94535900000483, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 178.27402700006496, graph 0       to   178.57794500002638, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 186.23777400003746, graph 0       to   187.26881699997466, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 190.21899600001052, graph 0       to   191.70634300005622, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    


      set obj rect       from 240.01362199999858, graph 0       to   340.0136219999986, graph 1       fillcolor rgb "#ff0000"       fillstyle transparent solid 0.05       noborder
    

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
  

$data_jevasmpszy0_ << JEVASMPSZY0_
2.001341999974102	0.006118	n2
32.97857300005853	-0.016113	n2
62.047293000039645	0.0061	n2
92.03768599999603	0.006089	n2
123.22681100002956	-0.019092	n2
152.0916440000292	0.006101	n2
183.36760600004345	-0.018007	n2
213.55411500006448	-0.019526	n2

3.997410999960266	0.00611	n3
35.242795999976806	-0.018505	n3
63.507901999983005	0.006094	n3
94.01219499995932	0.00609	n3
125.2504960000515	-0.016183	n3
154.00572500005364	0.00611	n3
185.5134529999923	-0.019604	n3
215.3985330000287	-0.020025	n3

5.998021999956109	0.006126	n4
66.48850600002334	0.006109	n4
96.37696200003847	0.006092	n4
156.44571700005326	0.006109	n4
218.81028099998366	0.006109	n4

8.14099400001578	0.006195	n5
39.652241999981925	-0.018655	n5
68.01165899995249	0.006083	n5
97.7401270000264	0.006109	n5
129.68159399996512	-0.014097	n5
158.2451590000419	0.006088	n5
219.11695100006182	0.006092	n5
JEVASMPSZY0_
    

  plot "$data_jevasmpszy0_" using 1:2 ti "session: -EZJjRg-" with linespoints, \
                    '' using 1:2:3 ti "" with labels offset 1, char 1
  

  unset multiplot
