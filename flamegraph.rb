def flamegraph # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  require 'stackprof'
  flamegraph_file_path = 'flamegraph.txt'
  report = StackProf.run(mode: :wall, interval: 1, ignore_gc: true, raw: true) do
    yield
  end

  File.open(flamegraph_file_path, 'w') do |file|
    StackProf::Report.new(report).print_timeline_flamegraph(file)
  end
  puts 'Open in browser:'
  system("stackprof --flamegraph-viewer=#{flamegraph_file_path}")
end

def a
  Array.new(100000) { |i| i }.shuffle.sort
  b
  c
end

def b
  Array.new(200000) { |i| i }.shuffle.sort
end

def c
  Array.new(300000) { |i| i }.shuffle.sort
end

flamegraph do
  a
end
