# :nodoc:
class AD
  def initialize
    @eh = EH.new
  end

  def a
    Calc.calc(1)
    b
    c
    @eh.g
    Calc.calc(4)
  end

  def b
    Calc.calc(2)
    c
  end

  def c
    Calc.calc(3)
    d
  end

  def d
    Calc.calc(4)
    @eh.e
  end
end
