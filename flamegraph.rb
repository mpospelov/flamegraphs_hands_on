require 'stackprof'

def flamegraph # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  flamegraph_file_path = 'flamegraph.txt'
  report = StackProf.run(mode: :cpu, interval: 500, ignore_gc: true, raw: true) do
    yield
  end

  File.open(flamegraph_file_path, 'w') do |file|
    StackProf::Report.new(report).print_timeline_flamegraph(file)
  end
  puts 'Open in browser:'
  system("stackprof --flamegraph-viewer=#{flamegraph_file_path}")
end

def calc(scale)
  Array.new(scale * 100000) { |i| i }.shuffle.sort
end

require 'net/http'
def net_call(*queries)
  uri = URI("https://www.google.com/search?q=#{queries.join(' and ')}")
  Net::HTTP.get(uri) # => String
end

def memoizable_calc(scale)
  @cache ||= {}
  @cache[scale] ||= calc(scale)
end

class AD
  def initialize
    @eh = EH.new
  end

  def a
    calc(1)
    b
    c
    @eh.g
    calc(4)
  end

  def b
    calc(2)
    c
  end

  def c
    calc(3)
    d
  end

  def d
    calc(4)
    @eh.e
  end
end

class EH
  def initialize
    @il = IL.new
  end

  def e
    calc(4)
    f
  end

  def f
    calc(4)
    g
  end

  def g
    calc(4)
    10.times { calc(5) }
    @il.i
    h
  end

  def h
    calc(5)
    10.times { calc(1) }
  end
end

class IL
  def initialize
    @mp = MP.new
  end

  def i
    calc(9)
    j
  end

  def j
    calc(3)
    k
  end

  def k
    calc(7)
    15.times { calc(2) }
    l
  end

  def l
    calc(10)
    5.times { calc(3) }
    @mp.m
  end
end

class MP
  def m
    net_call('a')
    5.times { net_call('b') }
    n
  end

  def n
    o
  end

  def o
    self.p
  end

  def p
    net_call('c')
  end
end

puts 'Started'
puts Time.now

flamegraph do
  AD.new.a
end
