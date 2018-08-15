require 'base64'
require 'date'
require 'pp'
require 'set'

def get_node_name(line)
  line.scan(/(n\d)/).flatten.first
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
  return "" if data.empty?

  default_duration = (data[1][:adjusted_time] - data[0][:adjusted_time]) rescue 100

  data.each_slice(2).map {|start,stop|
    %Q{
      set obj rect \
      from #{start[:adjusted_time]}, graph 0 \
      to   #{stop ? stop[:adjusted_time] : start[:adjusted_time] + default_duration}, graph 1 \
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

def plot_session_measurements(data)
  datablocks = []
  plots = []

  victorious_session = data.group_by {|x|
    x[:session_name]
  }.sort_by {|session, measurements|
    measurements.length
  }.reverse.first

  [victorious_session].each do |session, measurements|
    temp_name = Base64.encode64(session).gsub(/[^A-Za-z0-9]+/, '_').downcase
    data = measurements.group_by {|x| x[:node] }.map {|(node, m)|
        # group measurements by node so that they plot with a line between each one
        m.map {|x|
          x.values_at(:time_in_seconds, :offset_scaled, :node).join("\t")
        }.join("\n")
      }.join("\n\n")

    datablocks << %Q{
$data_#{temp_name} << #{temp_name.upcase}
#{data}
#{temp_name.upcase}
    }

    plots << %Q{"$data_#{temp_name}" using 1:2 ti "session: #{session.gsub(/[^A-Za-z0-9]+/, "-")}" with linespoints, \\
                    '' using 1:2:3 ti "" with labels offset 1, char 1}
  end

  %Q{
#{datablocks.join("\n\n")}

  plot #{plots.join(", \\\n")}
  }
end

title_params = []
tempo_points = {}
packet_stats = []
offset_measurements = []
node_boot_times = []
nemesis_booted_at = nil
nemesis_events = []
last_seen_now = 0.0
last_line = ""

ARGF.each.with_index do |l, idx|
  begin
    case l
    when /:topology/
      title_params << l.match(/(:topology "\w+")/).captures.first
    when /:network-delay-distribution/
      title_params << l.match(/(:network-delay-distribution "\w+"),/).captures.first
    when /:network-delay/
      title_params << l.match(/(:network-delay [\d\.]+),/).captures.first
    when /:nemesis,/
      next if l[/:isolated|healed|indeterminate/]

      event = parse_edn(l)
      nemesis_events << event.merge(:raw_time => event[:time] * 1e-9)
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
      session_name = l.scan(/Session (.{8})/).flatten.compact.first
      if session_name.nil?
        session_name = last_line.scan(/Session (.{8})/).flatten.compact.first
      end
      offset = l.scan(/\(1, -(\d+)+\)/).flatten.first.to_i
      offset_measurements << {node: node, session_name: session_name, offset: offset, last_seen_now: last_seen_now}
    when /Starting nemesis/
      nemesis_booted_at ||= DateTime.parse(l[/\d\d\d\d-\d\d-\d\d (\d\d:\d\d:\d\d,\d\d\d)/]).to_time.to_i
    when /starting test/
      node_boot_times << [get_node_name(l), DateTime.parse(l[/\d\d\d\d-\d\d-\d\d (\d\d:\d\d:\d\d,\d\d\d)/]).to_time.to_i]
    when /docker_default/
      if l[/udp/]
        node = get_node_name(l)
        pkts,bytes,fromnode = l.strip.match(/(\d+)\s+([\dKM]+)\s+udp\s+--\s+any\s+any\s+jepsen-(n\d)/).captures
        packet_stats << {node: node, pkts: pkts.to_i, bytes: bytes, fromnode: fromnode}
      end
    else
      # ignore
      # puts l
    end
  rescue Exception => e
    puts l
    puts e
  end

  last_line = l
end

# better algo
# find leader
# find offset
session_beat_origin = tempo_points.map {|k,v| v["values"].map{|y| y[:beat_zero] }.first }.sort.first
data = tempo_points.map {|k,v| v["values"].map {|x| [x[:now] - session_beat_origin, x[:tempo]]} }

offset_measurements = offset_measurements.map {|x|
  x.merge!({
    :time_in_seconds => x[:last_seen_now] - session_beat_origin,
    :offset_scaled => ((x[:offset] * 1e-6) - session_beat_origin).round(6),
  })
}

output = data.map {|node| node.map {|line| line.join("\t") }.join("\n") }.join("\n\n\n")

# Running multiple nemeses triggers multiple :start/:stop lines
# Here we take the first :start and the last :stop from each group
nemesis_events = nemesis_events.chunk {|x| x[:f] }.map {|x| x.first == :start ? x.last.first : x.last.last }

# These only being from when Jepsen has all nodes marked ready, whereas our
# measurements begin from when the first process boots
#
# allow 3 additional seconds for nemesis operations to complete
# difficult to parse these start times exactly so this is based on obeservation
#
# This takes into account a sleep based on the node number
# e.g. node 1 sleeps for a second, node 2 for 2 seconds etc.
# This is done to try to ensure a consistent session leader
first_node_booted_at = node_boot_times.map {|x| x.last + x.first[/\d/].to_i }.sort.first
nemesis_offset = (nemesis_booted_at - first_node_booted_at) + 1
# puts "Nem offset #{nemesis_offset}"
nemesis_events.map! {|ev| ev.merge(:adjusted_time => (ev[:raw_time] + nemesis_offset))}
nemesis_output = nemesis_events.map {|line| line.values_at(:adjusted_time, :f).join("\t") }.join("\n")

def agreement?(chunk)
  all_nodes_present = chunk.map {|x| x[:node] }.sort.to_set == ("n1".."n5").to_a.to_set
  tempos_match = chunk.map {|x| x[:tempo] }.uniq.length == 1

  all_nodes_present && tempos_match
end

# now that all the data is gathered, create a flat representation of the data
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

sorted_packet_stats = packet_stats.sort_by {|x|
  [x[:fromnode], x[:node]]
}
packet_output = sorted_packet_stats.group_by {|x|
  x[:fromnode]
}.map {|(fromnode, values)|
  values << {node: fromnode, pkts: "-", bytes: "-", fromnode: fromnode}
  values.sort_by {|v|
    v[:node]
  }.map {|x|
    "\"#{x[:pkts]}/#{x[:bytes]}\""
  }.join("\t")
}.join("\n")

all_nodes = ("n1".."n5").to_a.to_set

divergence_events = sorted_beat_data.slice_when {|i,j|
  i[:time_in_seconds].floor(1) != j[:time_in_seconds].floor(1)
}.to_a.map {|chunk|
  [chunk.first[:time_in_seconds], chunk.length, chunk.map{|x| x[:tempo] }.to_set, agreement?(chunk)]
}.slice_when {|a,b|
  # smooth out cases where tempo is constant
  # but nodes don't all fire at the same second
  # ((a.last != b.last) && (a[-3] + b[-3] == 10)) || (a[-2] != b[-2])
  a.last != b.last
}.map {|x|
  x.first
}

# find the index where we first see all 5 nodes
initialization_complete = divergence_events.find_index {|x| x[1] == 5 }

# smooth out blips where we don't get 5 consecutive observations but the tempo remains the same
divergence_events = divergence_events.map.with_index{|x,i| [x,i] }.each_slice(2).reject{|(a,b)|
  b && b.last > initialization_complete && (a.first[-2] == b.first[-2])
}.flatten(1).map {|x| x.first }

# drop the initial divergence as nodes join session
initialization_time = divergence_events.select {|x| x.last }.first.first

if divergence_events.length.even?
  total_divergence_time = divergence_events.each_slice(2).map {|(x,y)| y ? (y.first - x.first) : 0 }[1..-1].compact.inject{|sum,i| sum += i }
else
  # drop last because we don't converge again after that
  total_divergence_time = divergence_events[0..-2].each_slice(2).map {|(x,y)|
    y ? (y.first - x.first) : 0
  }[1..-1].compact.inject{|sum,i| sum += i }
end

if divergence_events.length <= 3
  # we drop first two to allow for initialization sometimes there's a hanging
  # divergence at the end too This doesn't affect the convergence figure
  # because we stop counting once a node has left
  total_divergence_time = 0.0
end

total_session_time = sorted_beat_data.select {|x| x[:peers] == 4 }.last[:time_in_seconds] - initialization_time
convergence_of_total = (100.0 - 100*(total_divergence_time / total_session_time)).round(3)

File.open('test_output.rbdump', 'wb') do |file|
  Marshal.dump({:tempo_points => tempo_points,
                :sorted_beat_data => sorted_beat_data,
                :offset_measurements_raw => offset_measurements}, file)
end

File.open('plot_data.dat', 'wb') do |file|
  IO.write(file, output)
end

File.open('nemesis_data.dat', 'wb') do |file|
  IO.write(file, nemesis_output)
end

File.open('packet_stats.tsv', 'wb') do |file|
  IO.write(file, packet_output)
end

def gnuplot(commands)
  IO.popen("gnuplot", "w") { |io| io.puts commands }
end

title_params.unshift "convergence #{convergence_of_total}%"
title_params.unshift "Tempo measurements"

commands = %Q(
  # set terminal pngcairo enhanced font "Helvetica,12.0" size 6400,800;
  # set output "plot.png"
  set terminal pdf size 29.7cm,21cm enhanced color font 'Helvetica'
  set output "plot.pdf"

  set autoscale x
  set lmargin 15 # accomodate different width ytics

  set multiplot layout 2, 1

  set title "#{title_params.join(" - ").gsub('"', '')}"

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
      linetype 1 linewidth 0.5 \
      pointtype 7 pointsize 0.5

  set style line 2  lc rgb '#0025ad' lt 1 lw 0.5 pt 2 ps 0.5# --- blue
  set style line 3  lc rgb '#0042ad' lt 1 lw 0.5 pt 3 ps 0.5#      .
  set style line 4  lc rgb '#0060ad' lt 1 lw 0.5 pt 4 ps 0.5#      .
  set style line 5  lc rgb '#007cad' lt 1 lw 0.5 pt 5 ps 0.5#      .
  set style line 6  lc rgb '#0099ad' lt 1 lw 0.5 pt 6 ps 0.5#      .
  set style line 7  lc rgb '#00ada4' lt 1 lw 0.5 pt 7 ps 0.5#      .
  set style line 8  lc rgb '#00ad88' lt 1 lw 0.5 pt 8 ps 0.5#      .
  set style line 9  lc rgb '#00ad6b' lt 1 lw 0.5 pt 9 ps 0.5#      .
  set style line 10 lc rgb '#00ad4e' lt 1 lw 0.5 pt 10 ps 0.5#      .
  set style line 11 lc rgb '#00ad31' lt 1 lw 0.5 pt 11 ps 0.5#      .
  set style line 12 lc rgb '#00ad14' lt 1 lw 0.5 pt 12 ps 0.5#      .
  set style line 13 lc rgb '#09ad00' lt 1 lw 0.5 pt 13 ps 0.5# --- green

  # plot for [n=1:5] 'plot_data.dat' with lines linestyle n
  plot 'plot_data.dat' index 0 title 'n1' with linespoints linestyle 1, \
     ''                index 1 title 'n2' with linespoints linestyle 4, \
     ''                index 2 title 'n3' with linespoints linestyle 7, \
     ''                index 3 title 'n4' with linespoints linestyle 10, \
     ''                index 4 title 'n5' with linespoints linestyle 13

  #
  set title "Clock offsets per Link session"

  set key
  set xrange restore
  set ytics
  # set logscale y
  # set format y "10^{%L}
  unset yrange
  set ylabel "Clock offset - seconds"
  #{plot_session_measurements(offset_measurements)}

  unset multiplot
)

# TODO: work out plotting of packet statistics (if any)
%Q(
set autoscale fix
set tics scale 1
unset cbtics
unset key

$packet_data << PKT
#{packet_output}
PKT

plot '$packet_data' matrix using 1:2:($3) with labels font ',16'
)

File.open('gnuplot_commands.gnu', 'wb') do |file|
  IO.write(file, commands)
end

gnuplot(commands)
