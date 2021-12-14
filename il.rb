# :nodoc:
class IL
  def initialize
    @mp = MP.new
  end

  def i
    Calc.calc(9)
    j
  end

  def j
    Calc.calc(3)
    k
  end

  def k
    Calc.calc(7)
    15.times { Calc.calc(2) }
    l
  end

  def l
    Calc.calc(10)
    5.times { Calc.calc(3) }
    @mp.m
  end
end
