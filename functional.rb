module Functional
  # doctest: Function composition.
  # >> sqr = lambda {|x| x * x }
  # >> inc = lambda {|x| x + 1 }
  # >> (sqr * inc)[5]
  # 36
  def compose(f)
    if self.respond_to?(:arity) and self.arity == 1
      lambda {|*args| self.call f[*args] }
    else
      lambda {|*args| self.call *f[*args] }
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
      lambda {|*args| func.call self[*args] }
    else
      lambda {|*args| func.call *self[*args] }
    end
  end
  alias | pipe

  # doctest: Partial functions - first arguments.
  # >> pow = lambda {|x, y| x ** y }
  # >> (pow >> 10)[2]
  # 100
  def apply_head(*first)
    lambda {|*rest| self.call *first.concat(rest) }
  end
  alias >> apply_head

  # doctest: Partial functions - last arguments.
  # >> pow = lambda {|x, y| x ** y }
  # >> (pow << 10)[2]
  # 1024
  def apply_tail(*last)
    lambda {|*rest| self.call *rest.concat(last) }
  end
  alias << apply_tail

  # doctest: Memoize - factorial.
  # >> fact = +lambda {|n| return 1 if n <= 1; n * fact[n-1]}
  # >> fact[10]
  # 3628800
  # doctest: Memoize - fibonacci.
  # >> fib = +lambda {|n| return n if n <= 1; fib[n-1] + fib[n-2] }
  # >> fib[100]
  # => 354224848179261915075 
  def memoize
    cache = {}
    lambda {|*args|
      # Try to fetch the cached value.
      # If key isn't there, make the function call
      # and cache the value for future calls.
      cache.fetch(args) { cache[args] = self.call(*args) }
    }
  end
  alias +@ memoize
end

class Proc; include Functional; end
class Method; include Functional; end
