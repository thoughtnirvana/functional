### Functional enhancements for ruby.

Some utils taken from the book "The Ruby Programming Language 6.8 Functional Programming"


#### Function composition.
    >> sqr = lambda {|x| x * x }
    >> inc = lambda {|x| x + 1 }
    >> (sqr * inc)[5]
    => 36

#### Function piping.
    >> sqr = lambda {|x| x * x }
    >> inc = lambda {|x| x + 1 }
    >> (sqr | inc)[5]
    => 26

#### Partial function - first arguments.
    >> pow = lambda {|x, y| x ** y }
    >> (pow >> 10)[2]
    => 100

#### Partial function - last arguments.
    >> pow = lambda {|x, y| x ** y }
    >> (pow << 10)[2]
    => 1024

#### Memoize.
    >> fact = +lambda {|n| return 1 if n <= 1; n * fact[n-1]}
    >> fact[10]
    => 3628800

    >> fib = +lambda {|n| return n if n <= 1; fib[n-1] + fib[n-2] }
    >> fib[100]
    => 354224848179261915075 

### Working with methods.

I couldn't think of anything else other than patching the `Symbol` module and overloading `+@`.

    >> def sqr(x)
    >>   x * x
    >> end

    >> def inc(x);
    >>   x + 1
    >> end

    >> (+:sqr | +:inc)[5]
    => 26

You can mix methods and lambdas.

    >> negate = lambda {|x| -x }
    >> (+:sqr | +:inc | negate)[5]
    => -26

