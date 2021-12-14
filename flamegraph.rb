# frozen_string_literal: true

require 'stackprof'

# collects flamegraph for given block
def flamegraph(&block)
  report = StackProf.run(mode: :cpu, interval: 500, ignore_gc: true, raw: true, &block)

  File.open('flamegraph.txt', 'w') do |file|
    StackProf::Report.new(report).print_timeline_flamegraph(file)
  end

  puts 'Open in browser:'
  system('stackprof --flamegraph-viewer=flamegraph.txt')
end

require_relative 'calc'
require_relative 'ad'
require_relative 'eh'
require_relative 'il'
require_relative 'mp' # < - this is our responsibility

def launch
  puts 'Started'
  puts Time.now

  flamegraph do
    AD.new.a
  end
end

launch
