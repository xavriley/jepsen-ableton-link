def get_node_name(line)
  line.scan(/\/(n\d)/)
end

ARGF.each do |l|
  begin
    case l
    when /:beat/
      puts eval(l.gsub(/^[^\{]+/, '').gsub('?', ''))
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
