# :nodoc:
class EH
  def initialize
    @il = IL.new
  end

  def e
    Calc.calc(4)
    f
  end

  def f
    Calc.calc(4)
    g
  end

  def g
    Calc.calc(4)
    10.times { Calc.calc(5) }
    @il.i
    h
  end

  def h
    Calc.calc(5)
    10.times { Calc.calc(1) }
  end
end
