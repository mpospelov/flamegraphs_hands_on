
# :nodoc:
class MP
  def m
    Calc.net_call('a')
    5.times { Calc.net_call('b') }
    n
  end

  def n
    o
  end

  def o
    self.p
  end

  def p
    Calc.net_call('c')
  end
end
