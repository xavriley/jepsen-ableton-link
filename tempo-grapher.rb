require 'set'

def get_node_name(line)
  line.scan(/\/(n\d)/).flatten.first
end

def parse_edn(line)
  edn_data = line.
    # tidy up start of line
    gsub(/\A(.+)\{\:/, '{:').
    # strip curly braces
    match(/{([^\}]+)}\Z/)[1].strip.
    # handle nested arrays - TODO: extract these properly
    # gsub(/\[([^\]]+)\]/, ':isolated').
    # split on ":<key> <value>"
    split(/(:[^\s]+)\s/).
    # remove blanks
    reject(&:empty?).
    # remove trailing commas
    map {|v| v.gsub(',', '') }.
    # replace - with _ for valid Ruby symbols
    map {|v| v.gsub('-', '_') }.
    # remove trailing spaces
    map(&:strip)

  # [key, val, key, val] has a to_hash method
  # vals are currently strings - use eval to get the proper Ruby types
  edn_data.each_slice(2).collect {|k,v| [k.gsub(':', '').to_sym, eval(v)] }.to_h
end

def nemesis_regions(data)
  default_duration = data[1].first - data[0].first

  data.each_slice(2).map {|start,stop|
    %Q{
      set obj rect \
      from #{start.first}, graph 0 \
      to   #{stop ? stop.first : start.first + default_duration}, graph 1 \
      fillcolor rgb "#000000" \
      fillstyle transparent solid 0.05 \
      noborder
    }
  }.join("\n\n")
end

def divergence_regions(data)
  data.each_slice(2).map {|start,stop|
    %Q{
      set obj rect \
      from #{start.first}, graph 0 \
      to   #{stop ? stop.first : start.first + 100}, graph 1 \
      fillcolor rgb "#ff0000" \
      fillstyle transparent solid 0.05 \
      noborder
    }
  }.join("\n\n")
end

nemesis_start_time = nil
tempo_points = {}
offset_measurements = []
nemesis_events = []
last_seen_now = 0.0

ARGF.each do |l|
  begin
    case l
    when /nemesis/
      next if l[/:isolated|healed|indeterminate/]

      event = parse_edn(l)
      nemesis_start_time ||= event[:time]
      nemesis_events << [(event[:time] - nemesis_start_time) * 1e-9, event[:f]]
    when /:beat/
      node = get_node_name(l)
      data = eval(l.gsub(/\A(.+)\{\:/, '{:').gsub('?', '').gsub(/\}(.+)\Z/, '}'))

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

# debug - output session name as well
# offset_measurements.map! {|x| ["\"#{x[:node]} #{x[:session_name]}\"", x[:last_seen_now] - session_beat_origin, ((x[:offset] * 1e-6) - session_beat_origin).round(6)]}
offset_measurements.map! {|x| [x[:node], x[:last_seen_now] - session_beat_origin, ((x[:offset] * 1e-6) - session_beat_origin).round(6)]}

# WIP plotting clock offset measurements using y2 axis
# would be nice to get labels with node names
# setting y1 to be 0..250 would make for an easier scaling factor of 1000ms
# maybe need to make it dynamic based on range of offsets
offset_output = offset_measurements.group_by {|x| x.first }.map {|k,v| (["# #{k}"] << v.map {|x| (x.flatten[1..2] << k).join("\t") }).join("\n") }.join("\n\n\n")

output = data.map {|node| node.map {|line| line.join("\t") }.join("\n") }.join("\n\n\n")

nemesis_output = nemesis_events.map {|line| line.join("\t") }.join("\n")

def agreement?(chunk)
  all_nodes_present = chunk.map {|x| x[:node] }.sort.to_set == ("n1".."n5").to_a.to_set
  tempos_match = chunk.map {|x| x[:tempo] }.uniq.length == 1

  all_nodes_present && tempos_match
end

beat_data = tempo_points.map {|k,v| v["values"].map {|x| x.merge(node: k) } }.flatten

sorted_beat_data = beat_data.map {|x|
  # decorate
  x.tap {|y|
    y[:beat] = y[:beat].round(2)
    y[:tempo] = y[:tempo].round
    y.merge!({:time_in_seconds => y[:now] - session_beat_origin})
  }
}.sort_by {|x|
  [x[:time_in_seconds], x[:phase]]
}

all_nodes = ("n1".."n5").to_a.to_set

# different approach
divergence_events = sorted_beat_data.slice_when {|i,j| i[:time_in_seconds] != j[:time_in_seconds] }.to_a.map {|chunk| [chunk.first[:time_in_seconds], agreement?(chunk)] }.chunk {|x|
  x.last
}.map {|x| x.last.first }


File.open('test_output.rbdump', 'wb') do |file|
  Marshal.dump(tempo_points, file)
end

File.open('plot_data.dat', 'wb') do |file|
  IO.write(file, output)
end

File.open('offset_data.dat', 'wb') do |file|
  IO.write(file, offset_output)
end

File.open('nemesis_data.dat', 'wb') do |file|
  IO.write(file, nemesis_output)
end

def gnuplot(commands)
  IO.popen("gnuplot", "w") { |io| io.puts commands }
end

commands = %Q(
  set terminal pngcairo enhanced font "Helvetica,12.0" size 6400,800;
  set output "plot.png"

  set autoscale x
  set lmargin 15 # accomodate different width ytics

  set multiplot layout 2, 1

  set style rect fc lt -1 fs solid 0.15 noborder
  #{nemesis_regions(nemesis_events)}

  #{divergence_regions(divergence_events)}

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
