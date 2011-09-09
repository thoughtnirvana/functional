module Functional
  # doctest: Function composition.
  # >> sqr = lambda {|x| x * x }
  # >> inc = lambda {|x| x + 1 }
  # >> (sqr * inc)[5]
  # 36
  def compose(f)
    if self.respond_to?(:arity) and self.arity == 1
      lambda {|*args| self.call(f.call(*args)) }
    else
      lambda {|*args| self.call(*f.call(*args)) }
    end
  end
  alias * compose

  # doctest: Function piping.
  # >> sqr = lambda {|x| x * x }
  # >> inc = lambda {|x| x + 1 }
  # >> (sqr | inc)[5]
  # 26
  def pipe(func)
    if func.respond_to?(:arity) and func.arity == 1
      lambda {|*args| func.call(self.call(*args)) }
    else
      lambda {|*args| func.call(*self.call(*args)) }
    end
  end
  alias | pipe

  # doctest: Partial functions - first arguments.
  # >> pow = lambda {|x, y| x ** y }
  # >> (pow >> 10)[2]
  # 100
  def apply_head(*first)
    lambda {|*rest| self.call(*first.concat(rest)) }
  end
  alias >> apply_head

  # doctest: Partial functions - last arguments.
  # >> pow = lambda {|x, y| x ** y }
  # >> (pow << 10)[2]
  # 1024
  def apply_tail(*last)
    lambda {|*rest| self.call(*rest.concat(last)) }
  end
  alias << apply_tail

  # doctest: Memoize.
  # >> fact = +lambda {|n| return 1 if n <= 1; n * fact[n-1]}
  # >> fact[10]
  # 3628800
  def memoize
    cache = {}
    lambda {|*args|
      unless cache.has_key?(args)
        cache[args] = self.call(*args)
      end
      cache[args]
    }
  end
  alias +@ memoize
end

class Proc; include Functional; end
class Method; include Functional; end
