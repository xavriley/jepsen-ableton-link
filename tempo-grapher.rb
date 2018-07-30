def get_node_name(line)
  line.scan(/\/(n\d)/).flatten.first
end

tempo_points = {}

ARGF.each do |l|
  begin
    case l
    when /:beat/
      node = get_node_name(l)
      data = eval(l.gsub(/^[^\{]+/, '').gsub('?', ''))

      tempo_points[node] ||= {}
      tempo_points[node]["values"] ||= []
      tempo_points[node]["beat_origin"] ||= data[:beat_zero]

      tempo_points[node]["values"] << data
    when /result \(1, /
      puts get_node_name(l)
      puts l.scan /\(1, -(\d+)+\)/
    else
      # ignore
      # puts l
    end
  rescue
  end
end

session_beat_origin = tempo_points.map {|k,v| v["values"].map{|y| y[:beat_zero] }.first }.sort.first
data = tempo_points.map {|k,v| v["values"].map {|x| [x[:now] - session_beat_origin, x[:tempo]]} }

output = data.map {|node| node.map {|line| line.join("\t") }.join("\n") }.join("\n\n\n")

File.open('test_output.rbdump', 'wb') do |file|
  Marshal.dump(tempo_points, file)
end

File.open('plot_data.dat', 'wb') do |file|
  IO.write(file, output)
end

def gnuplot(commands)
  IO.popen("gnuplot", "w") { |io| io.puts commands }
end

commands = %Q(
  set terminal png size 1600,800;
  set output "plot.png"

  set xlabel 'Time (seconds)'
  set ylabel 'Tempo (bpm)'

  # Set linestyle 1 to blue (#0060ad)
  set style line 1 \
      linecolor rgb '#0060ad' \
      linetype 1 linewidth 1.5 \
      pointtype 7 pointsize 1.5

  set style line 2  lc rgb '#0025ad' lt 1 lw 1.5 pt 2 ps 1.5# --- blue
  set style line 3  lc rgb '#0042ad' lt 1 lw 1.5 pt 3 ps 1.5#      .
  set style line 4  lc rgb '#0060ad' lt 1 lw 1.5 pt 4 ps 1.5#      .
  set style line 5  lc rgb '#007cad' lt 1 lw 1.5 pt 5 ps 1.5#      .
  set style line 6  lc rgb '#0099ad' lt 1 lw 1.5 pt 6 ps 1.5#      .
  set style line 7  lc rgb '#00ada4' lt 1 lw 1.5 pt 7 ps 1.5#      .
  set style line 8  lc rgb '#00ad88' lt 1 lw 1.5 pt 8 ps 1.5#      .
  set style line 9  lc rgb '#00ad6b' lt 1 lw 1.5 pt 9 ps 1.5#      .
  set style line 10 lc rgb '#00ad4e' lt 1 lw 1.5 pt 10 ps 1.5#      .
  set style line 11 lc rgb '#00ad31' lt 1 lw 1.5 pt 11 ps 1.5#      .
  set style line 12 lc rgb '#00ad14' lt 1 lw 1.5 pt 12 ps 1.5#      .
  set style line 13 lc rgb '#09ad00' lt 1 lw 1.5 pt 13 ps 1.5# --- green

  # plot for [n=1:5] 'plot_data.dat' with lines linestyle n
  plot 'plot_data.dat' index 0 title 'n1' with linespoints linestyle 1, \
     ''                index 1 title 'n2' with linespoints linestyle 4, \
     ''                index 2 title 'n3' with linespoints linestyle 7, \
     ''                index 3 title 'n4' with linespoints linestyle 10, \
     ''                index 4 title 'n5' with linespoints linestyle 13, \
)

gnuplot(commands)
