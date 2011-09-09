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
