def get_node_name(line)
  line.scan(/\/(n\d)/).flatten.first
end

tempo_points = {}
offset_measurements = []
last_seen_now = 0.0

ARGF.each do |l|
  begin
    case l
    when /:beat/
      node = get_node_name(l)
      data = eval(l.gsub(/^[^\{]+/, '').gsub('?', '').gsub(/\}(.+)\Z/, '}'))

      tempo_points[node] ||= {}
      tempo_points[node]["values"] ||= []
      tempo_points[node]["beat_origin"] ||= data[:beat_zero]

      tempo_points[node]["values"] << data
      last_seen_now = data[:now]
    when /result \(1, /
      # the leader of the session won't have a line like
      # Joining session XA]am+uA with tempo 120
      # unless they leave and then rejoin later
      #
      # the following line
      # Session XA]am+uA measurement completed with result (1, -103650941860)
      # the negative number is a timestamp in ns of where the node believes the
      # beat origin of the leader is. The last three digits are sub ms precision
      # Observations so far seem to suggest that the bounds are within 1ms of each other
      #
      # session leader doesn't measure against itself, obviously
      node = get_node_name(l)
      session_name = l.scan(/Session (.{8})/).flatten.first
      offset = l.scan(/\(1, -(\d+)+\)/).flatten.first.to_f
      offset_measurements << {node: node, session_name: session_name, offset: offset, last_seen_now: last_seen_now}
    else
      # ignore
      # puts l
    end
  rescue Exception => e
    puts l
    puts e
  end
end

session_beat_origin = tempo_points.map {|k,v| v["values"].map{|y| y[:beat_zero] }.first }.sort.first
data = tempo_points.map {|k,v| v["values"].map {|x| [x[:now] - session_beat_origin, x[:tempo]]} }

# puts "beat origin: #{session_beat_origin}"
victorious_session = offset_measurements.sort_by {|h| h[:last_seen_now] }.last[:session_name]
offset_measurements.reject! {|x| x[:session_name] != victorious_session }

offset_measurements.map! {|x| [x[:node], x[:last_seen_now] - session_beat_origin, ((x[:offset] * 1e-6) - session_beat_origin).round(6)]}

# WIP plotting clock offset measurements using y2 axis
# would be nice to get labels with node names
# setting y1 to be 0..250 would make for an easier scaling factor of 1000ms
# maybe need to make it dynamic based on range of offsets
offset_output = offset_measurements.group_by {|x| x.first }.map {|k,v| (["# #{k}"] << v.map {|x| (x.flatten[1..2] << k).join("\t") }).join("\n") }.join("\n\n\n")

output = data.map {|node| node.map {|line| line.join("\t") }.join("\n") }.join("\n\n\n")

File.open('test_output.rbdump', 'wb') do |file|
  Marshal.dump(tempo_points, file)
end

File.open('plot_data.dat', 'wb') do |file|
  IO.write(file, output)
end

File.open('offset_data.dat', 'wb') do |file|
  IO.write(file, offset_output)
end

def gnuplot(commands)
  IO.popen("gnuplot", "w") { |io| io.puts commands }
end

commands = %Q(
  set terminal pngcairo enhanced font "Helvetica,12.0" size 1600,800;
  set output "plot.png"

  set autoscale x
  set lmargin 15 # accomodate different width ytics

  set multiplot layout 2, 1

  set xrange [] writeback
  set xlabel 'Time (seconds)'
  set ylabel 'Tempo (bpm)'

  set yrange [0:220]
  set ytics nomirror

  # Set linestyle 1 to blue (#0060ad)
  set style line 1 \
      linecolor rgb '#0060ad' \
      linetype 1 linewidth 2.5 \
      pointtype 7 pointsize 2.5

  set style line 2  lc rgb '#0025ad' lt 1 lw 2.5 pt 2 ps 2.5# --- blue
  set style line 3  lc rgb '#0042ad' lt 1 lw 2.5 pt 3 ps 2.5#      .
  set style line 4  lc rgb '#0060ad' lt 1 lw 2.5 pt 4 ps 2.5#      .
  set style line 5  lc rgb '#007cad' lt 1 lw 2.5 pt 5 ps 2.5#      .
  set style line 6  lc rgb '#0099ad' lt 1 lw 2.5 pt 6 ps 2.5#      .
  set style line 7  lc rgb '#00ada4' lt 1 lw 2.5 pt 7 ps 2.5#      .
  set style line 8  lc rgb '#00ad88' lt 1 lw 2.5 pt 8 ps 2.5#      .
  set style line 9  lc rgb '#00ad6b' lt 1 lw 2.5 pt 9 ps 2.5#      .
  set style line 10 lc rgb '#00ad4e' lt 1 lw 2.5 pt 10 ps 2.5#      .
  set style line 11 lc rgb '#00ad31' lt 1 lw 2.5 pt 11 ps 2.5#      .
  set style line 12 lc rgb '#00ad14' lt 1 lw 2.5 pt 12 ps 2.5#      .
  set style line 13 lc rgb '#09ad00' lt 1 lw 2.5 pt 13 ps 2.5# --- green

  # plot for [n=1:5] 'plot_data.dat' with lines linestyle n
  plot 'plot_data.dat' index 0 title 'n1' with linespoints linestyle 1, \
     ''                index 1 title 'n2' with linespoints linestyle 4, \
     ''                index 2 title 'n3' with linespoints linestyle 7, \
     ''                index 3 title 'n4' with linespoints linestyle 10, \
     ''                index 4 title 'n5' with linespoints linestyle 13

  #
  set title "Clock offsets"

  unset key
  set xrange restore
  set ytics
  unset yrange
  set ylabel "Clock offset (seconds)"
  plot 'offset_data.dat' using 1:2 ti 'offset_data.dat', \
                      '' using 1:2:3 with labels offset 0, char 1

  unset multiplot
)

gnuplot(commands)
