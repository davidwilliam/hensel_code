# HenselCode

![example workflow](https://github.com/davidwilliam/hensel_code/actions/workflows/main.yml/badge.svg) [![codecov](https://codecov.io/gh/davidwilliam/hensel_code/branch/main/graph/badge.svg?token=XJ0C0U7P2M)](https://codecov.io/gh/davidwilliam/hensel_code) [![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop) ![GitHub](https://img.shields.io/github/license/davidwilliam/hensel_code) ![Gem](https://img.shields.io/gem/v/hensel_code) ![GitHub release (latest by date)](https://img.shields.io/github/v/release/davidwilliam/hensel_code)

***NOTICE:*** this README is beign constantly updated. I am currently focused on coding since I want to release as many different types of Hensel codes and as many interesting features as time allows. At the same time, I want this README to be as informative as possible even for those completely unfamiliar with p-adic numbers and Hensel codes. 

Hensel Code allows you to homomorphically encode rational numbers as integers using the finite-segment p-adic arithmetic, also known as Hensel codes. 

T. M. Rao describes the use of finite-segment p-adic arithmetic as a practical method for performing error-free computation and the term *Hensel code* as the first `r` digits of the infinite p-adic expansion of a rational number `x/y`. The use of Hensel codes allows us to replace the arithmetic opertations on rational numbers by corresponding aritmetic operation over the integers under certain conditions.

Rao also remarks that the theory of Hensel codes, although lifted from the p-adic number theory, can be introduced without the need of a complete undertanding of the theoretical aspects of p-adic numbers if the goal is to work with Hensel codes alone. This is due to the fact that the finite-segment p-adic arithmetic is well-defined, self-contained, and it has immediate pratical applications in a wide range of real-world scenarios.

Ç. K. Koç remarks that the p-adic arithmetic allows error-free representation of fractions and error-ree arithmetic using fractions where infinite-precision p-adic arithemtic is more suitable for software implementation and finite-precision p-adic arithmetic is more suitable for hardware implementations.

A p-adic number can be uniquely written as a inifite p-adic expansion, for `p` prime, where the associated coefficients are integers between `0` and `p - 1`. When this p-adic expansion is finite in length, then we have a finite-segment p-adic expansion. When we only consider the constant term of a p-adic expansion, then we have a truncated finite-segment p-adic expansion. There many types of representations of rationals lifted from the p-adic number theory, and therefore many types of Hensel codes.

## History

The theory of p-adic numbers was introduced by Kurt Hensel in the early 1900's ([Theorie der algebraischen Zahlen](https://books.google.com/books?hl=en&lr=&id=0w3vAAAAMAAJ&oi=fnd&pg=PR3&dq=Theorie+der+algebraischen+Zahlen&ots=kQfsAd0GYZ&sig=dGsTggln9njYkc2zNYT5hkk2lXU#v=onepage&q=Theorie%20der%20algebraischen%20Zahlen&f=false)). Introductions to p-adic numbers are provided by George Bachman (Introduction to p-Adic Numbers and Valuation Theory), Neal Koblitz ([P-Adic Numbers, P-Adic Analysis, and Zeta Functions](https://books.google.com/books?hl=en&lr=&id=8sTgBwAAQBAJ&oi=fnd&pg=PA1&dq=P-Adic+Numbers,+P-Adic+Analysis,+and+Zeta+Functions&ots=fWIImSqW7-&sig=29LdWtpjSkmQ2kWvVFDmmG5SsOo#v=onepage&q=P-Adic%20Numbers%2C%20P-Adic%20Analysis%2C%20and%20Zeta%20Functions&f=false)), Kurt Mahler ([Introduction to p-adic numbers and their functions](https://books.google.com/books?hl=en&lr=&id=kbc8AAAAIAAJ&oi=fnd&pg=PA1&dq=Introduction+to+P-Adic+Numbers+and+Their+Functions&ots=GFpDeD8vMG&sig=TNSPVG0YA676rlflM9CfogQP7t8)), and Fernando Gouveia ([p-adic Number](https://books.google.com/books?hl=en&lr=&id=VWjsDwAAQBAJ&oi=fnd&pg=PR5&ots=MdgpeNTWLX&sig=9LzgTUkSzN76E1EOD7wna0c8S0I#v=onepage&q&f=false)).

The foundation of the particular application of finite-segement p-adic arithemetic (also known as Hensel codes) for error-free computation can be found in the works of Alparslan, Krishnamurthy, Rao, and Subramanian (Finite p-adic number systems with possible applications, [Finite segmentp-adic number systems with applications to exact computation](https://link.springer.com/article/10.1007/BF03051174), [p-Adic arithmetic procedures for exact matrix computations](https://link.springer.com/article/10.1007/BF03046725), [Error-Free Polynomial Matrix Computations](https://link.springer.com/book/10.1007/978-1-4612-5118-7)), Gregory ([Methods and Applications of Error-Free Computation](https://link.springer.com/book/10.1007/978-1-4612-5242-9), [Error-free computation with rational numbers](https://link.springer.com/article/10.1007/BF01933164), [Error-free computation with finite number systems](https://dl.acm.org/doi/abs/10.1145/1057502.1057503?casa_token=LTLotJJYEPAAAAAA:PQwNY8-RcpuSQyfCkEMv1xIpd10RlR-y7JeTWkCkYNQ3c1IroGEGzk4TVH_5JJ954sJsvcHRlTldtQ), [The use of finite-segmentp-adic arithmetic for exact computation](https://link.springer.com/article/10.1007/BF01930898)), Miola ([Algebraic approach to p-adic conversion of rational numbers](https://www.sciencedirect.com/science/article/abs/pii/002001908490022X)), Morrison ([Parallel p-adic computation](https://www.sciencedirect.com/science/article/abs/pii/0020019088901597)). Many algorithms, ideas, and concepts in Hensel codes are greatly benefitted by the remarkable series The Art of Computer Programming by Donald Knuth. 

## Mathematical Background

In our Wiki, you can find a brief [introduction to the mathematical background on Hensel codes](https://github.com/davidwilliam/hensel_code/wiki/Mathematical-Background). We will continue to update that area as we update the gem.

## Applications

You can also find information about [possible applications with Hensel codes](https://github.com/davidwilliam/hensel_code/wiki/Applications).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hensel_code'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install hensel_code

# HenselCode

There are several types of Hensel codes in the finite-segment p-adic number theory. There are currently three of them available in the gem HenselCode: 

1. Truncated finite-segment p-adic Hensel codes
2. Finite-segment p-adic Hensel codes 
3. Truncated finite-segment g-adic Hensel codes
4. Finite-segmenet g-adic Hensel codes

For each type of supported Hensel code I will briefly discuss their properties and capabilities as well as unique features that make each type of Hensel code distinct from each other.

## Truncated finite-segment p-adic Hensel codes

### Description

The truncated finite-segment p-adic Hensel codes are integer representations of rationals with respect to a prime `p` and a positive exponent `r`. This integer representation of any given rational is equivalent to a constant term of the finite-segment p-adic expansion that represents that rational.

### Unique Benefits

The truncated finite-segment p-adic Hensel codes are the simplest type of Hensel codes and the easiest ones to perform computations on it. Given a prime `p` and an exponent `r`, Hensel codes are integers between `0` and `p^r - 1`. In Ruby, as in many other modern scripting languages, integers can be arbitarily large, and therefore `p` can be as large as computationally affordable. Addition, subtraction, multiplication, and division on Hensel codes are simply these operations modulo `p^r`. Encoding and decoding are also straightforward. Its use is ideal for applications with very large numbers and/or many consecutive homomorphic computations on Hensel codes, which can be achieved with the efficincy of computations over the integers.

### Usage

Let `p=257` and `r=3`. Given two rational numbers `rat1 = Rational(3,5)` and `rat2 = Rational(4,3)`, we encode `rat1` and `rat2` as follows:

```ruby
h1 = HenselCode::TruncatedFinitePadicExpansion.new(p, r, rat1)
# => <HenselCode: 13579675>
h2 = HenselCode::TruncatedFinitePadicExpansion.new(p, r, rat1)
# => <HenselCode: 5658199>
h1.n
# => 2913
h1.prime
# => 257
h1.exponent
# => 3
h1.modulus
# => 16974593
h1.class
# => HenselCode::TruncatedFinitePadicExpansion
h2.class
# => HenselCode::TruncatedFinitePadicExpansion
puts h1
# => 13579675
puts h2
# => 5658199
```

Now we can carry arithmetic computations on the `h1` and `h2` objects as if we were computing over `rat1` and `rat2`:

```ruby
h1_plus_h2 = h1 + h2
# => <HenselCode: 2263281>
h1_minus_h2 = h1 - h2
# => <HenselCode: 7921476>
h1_times_h2 = h1 * h2
# => <HenselCode: 6789838>
h1_div_h2 = h1 / h2
# => <HenselCode: 5941108>
h2.inverse
# => <HenselCode: 4243649>
h1 * h2.inverse
# => <HenselCode: 5941108>
h2 * h2.inverse
# => <HenselCode: 1>
```

All the computations are reduced modulo `p^r`.

At any moment, we can check the rational representation of the results we produced:

```ruby
h1_plus_h2.to_r
# => (29/15)
h1_minus_h2.to_r
# => (-11/15)
h1_times_h2.to_r
# => (4/5)
h1_div_h2.to_r
# => (9/20)
```

And we can verify that

```ruby
rat1 + rat2
# => (29/15)
rat1 - rat2
# => (-11/15)
rat1 * rat2
# => (4/5)
rat1 / rat2
# => (9/20)
```

### Which Prime Should I Use?

The choice of the prime you should use for encoding rationals into integers depends on two factors:

1. What rationals you want to encode,
2. What computations you want to perform over the encoded rationals.

To help you in this decision, given any Hensel code object `h`, you can check `h.n`:

```ruby
h = HenselCode::TruncatedFinitePadicExpansion.new p, r, Rational(2,3)
# => <HenselCode: 11316396>
h.n
# => 2913
```

In the mathematical background provided on our Wiki, you will see that the fractions associated with any choise of `p` and `r` are bounded by a value of `N`. In the HenselCode gem we refer to `n`, since capital letters are reserved to constants in Ruby. In the above example, we can encode fractions with numerator and denominator bounded in absolute value to `n` and we can perform computations on Hensel codes until a result that encodes a rational number with numerator and denominator bounded in absolute value to `n`. 

### Correctness Depends on the Choices for `p` and `r`

If `p = 7` and `r = 2`, then `n = 4`. If I try to encode a rational number `rat = Rational(11,23)` with my choices of `p` and `r` I will not obtain the intended result:

```ruby
rat = Rational(11,23)
h = HenselCode::TruncatedFinitePadicExpansion.new p, r, rat
# => <HenselCode: 9>
h.to_r
# => (-4/5)
```

So, instead of `11/23`, we obtain `-4/5` and this happens because `n = 4` and the rational number `11/23` does not have numerator and denominator bounded in absolute value to `n`. Therefore correctness fails.

The same occurs with computation on Hensel codes. If `rat1 = Rational(2,3)` and `rat2 = Rational(3,4)`, both `rat1` and `rat2` can be correctly encoded and decoded with our choice of `p` and `r` since they both have numerators and denominators bounded in absolute value to `n = 4`. However, computation addition of `rat1` and `rat2` will fail correctness since the result violates the bound imposed by `n`:

```ruby
h1 = HenselCode::TruncatedFinitePadicExpansion.new p, r, rat1
# => <HenselCode: 17>
h2 = HenselCode::TruncatedFinitePadicExpansion.new p, r, rat2
# => <HenselCode: 13>
h1_plus_h2 = h1 + h2
# => <HenselCode: 30>
h1_plus_h2.to_r
# => (3/5)
```

We obtain the incorrect result because `2/3 + 2/4 = 17/12` and this result is not supported by `p = 7` and `r = 2`. 

If instead we define `p = 56807` and `r = 3`, we have:

```ruby
h1 = HenselCode::TruncatedFinitePadicExpansion.new p, r, rat1
# => <HenselCode: 122212127593296>
h2 = HenselCode::TruncatedFinitePadicExpansion.new p, r, rat2
# => <HenselCode: 137488643542458>
h1_plus_h2 = h1 + h2
# => <HenselCode: 76382579745811>
h1_plus_h2.to_r
# => (17/12)
```

This time we obtain the correct result because `h1.n = 9573875`, and therefore correctness is guaranteed to any result associated with a numerator and a denominator bounded in absolute value to `9573875`.

Thefore, the larger `p` and `r` are, the larger the rationals one can correctly encode and decode and the more computations on Hensel codes will be perfomed and correctly decoded.

### It Could Be Any Integer, But...

The p-adic number theory establishes that `p` is a prime number. The fact that a prime number does not share any common divisor (other than `1`) with any other number smaller than itself makes it a very special number.

However, as an example, one could decided that `p = 25` and `r = 3`. Notice that `25` is not prime, yet, will work for some cases:

```ruby
p = 25
r = 3
rat1 = Rational(1,2)
h1 = HenselCode::TruncatedFinitePadicExpansion.new p, r, rat1
# => <HenselCode: 7813>
h1.to_r
# => (1/2)
```

However, it will fail in the following case:

```ruby
rat2 = Rational(2,5)
h2 = HenselCode::TruncatedFinitePadicExpansion.new p, r, rat2
# => 5 has no inverse modulo 15625 (ZeroDivisionError)
```

We can't compute a Hensel code for `2/5` with `p = 25` and `r = 3` because `gcd(5,25) = 5` and therefore there is no modular multiplicative inverse of `5` modulo `25`.

Therefore it is important that `p` is a prime (preferred), or a prime power power (less interesting since we already have `r`), or a prime composite (it can be useful for larger prime factors).
### Constraints

In order to operate on two or more Hensel codes, they all must be of the same object type and have the same prime and exponent, otherwise HenselCode will raise an exception. Again, let `rat1 = Rational(3,5)` and `rat2 = Rational(4,3)`, and `p1 = 241`, `p2 = 251`, `r1 = 3`, and `r2 = 4`:

```ruby
h1 = HenselCode::TruncatedFinitePadicExpansion.new(p1, r1, rat1)
# => <HenselCode: 5599009>
h2 = HenselCode::TruncatedFinitePadicExpansion.new(p1, r2, rat1)
# => <HenselCode: 1349361025>
h3 = HenselCode::TruncatedFinitePadicExpansion.new(p2, r1, rat1)
# => <HenselCode: 6325301>
h4 = HenselCode::TruncatedFinitePadicExpansion.new(p2, r2, rat1)
# => <HenselCode: 1587650401>
```

The following operations will raise exceptions:

```ruby
h1 + h2
# => 5599009 has exponent 3 while 1349361025 has exponent 4 (HenselCode::HenselCodesWithDifferentExponents)
h1 + h3
# => 5599009 has prime 241 while 6325301 has prime 251 (HenselCode::HenselCodesWithDifferentPrimes)
h1 + h4
# => 5599009 has prime 241 and exponent 3 while 1587650401 has prime 251 and exponent 4 (HenselCode::HenselCodesWithDifferentPrimesAndExponents)
num = 5
h1 + num
# => 5599009 is a HenselCode::TruncatedFinitePadicExpansion while 5 is a Integer (HenselCode::IncompatibleOperandTypes)
```

### Manipulating Hensel Code Objects

Let `p = 541`, `r = 3`, `rat = Rational(11,5)`. We create a Hensel code as before:

```ruby
h = HenselCode::TruncatedFinitePadicExpansion.new p, r, rat
# => <HenselCode: 126672339>
```

We can change the prime and the exponent:

```ruby
p = 1223
r = 4
h.replace_prime(p)
# => <HenselCode: 731710629>
h.replace_exponent(r)
# => <HenselCode: 1789764193155>
```

Any change in the prime and/or the exponent of a Hensel code object will change the Hensel code value and the modulus as well, however, the Hensel code object continues to refer to represent the same rational number:

```ruby
h.to_r
# => (11/5)
```

We can also change the rational number:

```ruby
rat = Rational(13,7)
h.replace_rational(rat)
# => <HenselCode: 1278402995111>
h.to_r
# => (13/7)
```

We can initiate a Hensel code object with its Hensel code value, instead of a rational number:

```ruby
h = HenselCode::TruncatedFinitePadicExpansion.new p, r, 53673296543
# => <HenselCode: 53673296543>
```

and then we can check what is the rational number represented by the resulting object:

```ruby
h.to_r
# => (706147/633690)
```

We can update the Hensel code value of an existing Hensel code object:

```ruby
h.replace_hensel_code(38769823656)
# => <HenselCode: 38769823656>
```

## Polynomials

In order to support finite-segment p-adic Hensel codes, the HenselCode gem offers an engine for computing fixed-length polynomials where all the computations ared reduced modulo `p`.

Let `p = 257`. We intantiate polynomials as follows:

```ruby
f = HenselCode::Polynomial.new p, [29, 102, 232]
# => <Polynomial: 29 + 102p + 232p^2>
g = HenselCode::Polynomial.new p, [195, 83, 244]
# => <Polynomial: 195 + 83p + 244p^2>
f.prime
# => 257
f.coefficients
# => [29, 102, 232]
f.degree
# => 2
puts f
# => 29 + 102p + 232p^2
```

### Arithmetic

All the mathematical oeprations objects of the `Polynomial` are over fixed-length single-variable polynomails in non-standard form (the terms are in ascending order with respect to their degrees). All the computation on the polynomial coefficients are reduced modulo `p` in every single step of unitary calculations, that is, no indivudal step of computation exceeds an addition followed by a binary multiplication in which the operands are bounded by `p` (a carry + a product of two integers). Therefore, if `p` has bit length `b`, the maximum space required for expanding the result of each step of computation is `1 + 2b` bits.

```ruby
f + g
# => <Polynomial: 224 + 185p + 219p^2>
f - g
# => <Polynomial: 91 + 18p + 245p^2>
f * g
# => <Polynomial: 1 + 217p + 216p^2>
f / g
# => <Polynomial: 70 + 238p + 233p^2>
g.inverse
# => <Polynomial: 29 + 234p + 219p^2
f * g.inverse
# => <Polynomial: 70 + 238p + 233p^2>
g * g.inverse
# => <Polynomial: 1 + 0p + 0p^2>
```

### Constraints

Operations with fixed-length polynomials require operands with the same degree:

```ruby
f = HenselCode::Polynomial.new p, [29, 102, 232]
# => <Polynomial: 29 + 102p + 232p^2>
g = HenselCode::Polynomial.new p, [195, 83, 244, 99]
# => <Polynomial: 195 + 83p + 244p^2 + 99p^3>
f.degree
# => 2
g.degree
# => 3
f + g
# => polynomials must have same degree (HenselCode::WrongHenselCodeInputType)
```

Operations with fixed-length polynomials also require operands with the same prime:

```ruby
f = HenselCode::Polynomial.new 251, [133, 206, 58]
# => <Polynomial: 133 + 206p + 58p^2>
g = HenselCode::Polynomial.new 257, [105, 129, 238]
# => <Polynomial: 105 + 129p + 238p^2>
f + g
# => polynomials must have same prime (HenselCode::WrongHenselCodeInputType)
g.prime = 251
# => 251
f + g
# => <Polynomial: 238 + 84p + 46p^2>
```

## Finite-segment p-adic Hensel codes

### Description
The finite-segment p-adic Hensel code is a p-adic integer that can be seen as a polynomial of degree `r - 1` in non-standard form (increasing degree order). Each coefficient of such polynomials are called *p-adic digits* ranging from `0` to `p - 1`. Computations on p-adic digits reduced modulo `p` must take the *carry* into consideration so we can guarantee that the results of addition, subtraction, multiplication, and division also range from `0` to `p - 1`.

### Unique Benefits
The finite-segment p-adic Hensel code takes advantage of the finite-segmenet p-adic number system in which we can compute all four basic arithemtic operations (and consequently, any function) without requiring a substantial expansion in space for each individual computation. In fact, as mentioned in the section on Polynomials, given a prime `p` of bit length `b`, all unitary computations will take at most `1 + 2b` bits.

In Ruby, as is several other scripting languages, we can work with arbitrarily large integers and therefore the truncated p-adic Hensel code can be a good choice for representing large rational numbers. However, Ruby can run in a variety of systems, some of which will have limited resources, such as many instances in the IoT world. Additionally, a Ruby application can be one amongts many other components that together compose a larger application. Some of these other components might run in systems with integers limited to small bit lengths, say, 16. This is where finite-segment p-adic Hensel codes can be intrumental by allowing arbitrarily large p-adic expansions with coefficients bounded to a small prime. 

### Usage

Let `p = 359`, `r = 3`, and `rat = Rational(2,3)`:

```ruby
h1 = HenselCode::FinitePadicExpansion.new p, r, rat
# => <HenselCode: 240 + 119p + 239p^2>
puts h1
# => 240 + 119p + 239p^2
```

We say that `h` is a p-adic number with `r` digits. We clearly see the correspondence of p-adic digits if we compute a truncated Hensel code with the same `p` but `r=1`:

```ruby
h2 = HenselCode::TruncatedFinitePadicExpansion.new p, r, rat
# => <HenselCode: 240>
```

Notice that the truncated Hensel code `h2` equals the first digit of the finite-segment Hensel code `h1`, which is also the same of computing

```ruby
HenselCode::FinitePadicExpansion.new p, 1, rat
# => <HenselCode: 240>
```

The following expressions are equivalent (they represent the same quantity):

```ruby
r = 3
h1 = HenselCode::FinitePadicExpansion.new p, r, rat
# => <HenselCode: 240 + 119p + 239p^2>
h1.to_r
# => (2/3)
h2 = HenselCode::TruncatedFinitePadicExpansion.new p, r, rat
# => <HenselCode: 30845520>
h2.to_r
# => (2/3)
```

that is, they not only represent the same rational but also `30845520` is just the evaluation of the polynomial `240 + 119p + 239p^2`.

We can obtain just the coefficients of `h1` as follows:

```ruby
h1.to_a
# => => [240, 119, 239]
```

We can obtain the truncated version of `h1` as follows:

```ruby
h1.to_truncated
# => <HenselCode: 30845520>
h1.to_truncated.class
# => HenselCode::TruncatedFinitePadicExpansion
```

#### Arithmetic

Let `p = 409`, `r = 5`, `rat1 = Rational(2,3)` and `rat2 = Rational(11,7)` such that

```ruby
h1 = HenselCode::FinitePadicExpansion.new p, r, rat1
# => <HenselCode: 137 + 136p + 136p^2 + 136p^3 + 136p^4>
h2 = HenselCode::FinitePadicExpansion.new p, r, rat2
# => <HenselCode: 60 + 292p + 233p^2 + 350p^3 + 116p^4>
```

We compute addition, subtraction, multiplication, and division as follows:

```ruby
h1_plus_h2 = h1 + h2
# => <HenselCode: 197 + 19p + 370p^2 + 77p^3 + 253p^4>
h1_minus_h2 = h1 - h2
# => <HenselCode: 77 + 253p + 311p^2 + 194p^3 + 19p^4>
h1_times_h2 = h1 * h2
# => <HenselCode: 40 + 331p + 155p^2 + 97p^3 + 214p^4>
h1_div_h2 = h1 / h2
# => <HenselCode: 50 + 161p + 12p^2 + 347p^3 + 309p^4>
h2.inverse
# => <HenselCode: 75 + 37p + 223p^2 + 111p^3 + 260p^4>
h1 * h2.inverse
# => <HenselCode: 50 + 161p + 12p^2 + 347p^3 + 309p^4>
h2 * h2.inverse
# => <HenselCode: 1 + 0p + 0p^2 + 0p^3 + 0p^4>
```

And we can verify that

```ruby
h1_plus_h2.to_r
# => (47/21)
rat1 + rat2
# => (47/21)
rat1 - rat2
# => (-19/21)
h1_minus_h2.to_r
# => (-19/21)
h1_times_h2.to_r
# => (22/21)
rat1 * rat2
# => (22/21)
h1_div_h2.to_r
# => (14/33)
rat1 / rat2
# => (14/33)
```

## Truncated finite-segment g-adic Hensel codes
### Description
Kurt Mahler refers to p-adic numbers based on multiple distinct primes as `g-adic numbers` (Lectures on Diophantine Approximations, 1961 and Introduction to p-adic Numbers and Their Functions, 1973). John F. Morrison, 1988, remarks that `g` is the product of `k` distinct primes, which are used to generate a g-adic number with a unique g-adic representation. 

### Unique Benefits

Since each digit of a truncated finite-segment g-adic Expansion (or simply truncated g-adic Hensel codes) is independently computed with respect to their corresponding prime, we can carry computations on each digit also independetly. This makes the truncated g-adic Hensel codes ideal for parallel/distributed processing, that is, given a rational number, several g-adic digits of that rational are independently computed and computations can be carried on those digits, also indpendently. 

### Usage

Let `primes = [241, 251, 257]`, `r = 3`, `rat1 = Rational(2,3)`, and `rat2 = Rational(5,4)`:

```ruby
h1 = HenselCode::TruncatedFiniteGadicExpansion.new primes, r, rat1
# => <HenselCode: [4665841, 10542168, 11316396]>
h2 = HenselCode::TruncatedFiniteGadicExpansion.new primes, r, rat2
# => <HenselCode: [10498142, 3953314, 12730946]>
h1.primes
# => [241, 251, 257]
h1.exponent
# => 3
h1.g
# => 15546187
h1.n
# => 43343186168
h1.hensel_code
# => [<HenselCode: 4665841>, <HenselCode: 10542168>, <HenselCode: 11316396>]
h1.to_r
# => (2/3)
h2.to_r
# => (5/4)
```

### Arithmetic

We compute addition, subtraction, multiplication, and division as follows:

```ruby
h1_plus_h2 = h1 + h2
# => <HenselCode: [1166462, 14495482, 7072749]>
h1_minus_h2 = h1 - h2
# => <HenselCode: [8165220, 6588854, 15560043]>
h1_times_h2 = h1 * h2
# => <HenselCode: [2332921, 13177710, 14145495]>
h1_div_h2 = h1 / h2
# => <HenselCode: [6532177, 2108434, 15842954]>
h2.inverse
# => <HenselCode: [2799505, 3162651, 6789838]>
h1 * h2.inverse
# => <HenselCode: [6532177, 2108434, 15842954]>
h2 * h2.inverse
# => <HenselCode: [1, 1, 1]>
```

And we can verify that

```ruby
h1_plus_h2.to_r
# => (23/12)
rat1 + rat2
# => (23/12)
rat1 - rat2
# => (-7/12)
h1_minus_h2.to_r
# => (-7/12)
h1_times_h2.to_r
# => (5/6)
rat1 * rat2
# => (5/6)
h1_div_h2.to_r
# => (8/15)
rat1 / rat2
# => (8/15)
```

### Relatable, and yet, Unique

When we execute the following:

```ruby
h1.hensel_code
# => [<HenselCode: 4665841>, <HenselCode: 10542168>, <HenselCode: 11316396>]
```

it is clear that the truncated g-adic Hensel code is a collection of individual Hensel codes, each one computed for the same rational but with distinct primes. One can be tempted to think that these multiple independent Hensel codes are "extra" material, not really needed for representing the given rational. This is far from the truth. Besides enabling parallel/distributed computaitons over Hensel codes (which is already a great benefit to have), to illustrate another aspect of working with truncated g-adic Hensel codes, consider the rational `rat3 = Rational(37897,52234)`:

```ruby
h3 = HenselCode::TruncatedFiniteGadicExpansion.new primes, r, rat3
# => <HenselCode: [3698890, 5577355, 7406440]>
h3.hensel_code
# => [<HenselCode: 3698890>, <HenselCode: 5577355>, <HenselCode: 7406440>]
```

We can clearly see that each Hensel code in the truncated g-adic Hensel code is only a partial representation of `rat3` when we decode each individual Hensel code to see which rational they are representing:

```ruby
h3.hensel_code.map(&:to_r)
# => [(1471/4613), (409/981), (-207/3298)]
```

None of the above rationals equals `rat3`. The reason is that each individual prime in `primes` are insufficient for representing `rat3` and therefore they can only, individually, partially represent `rat3`. However, when considered as part of the same g-adic number system, they can jointly represent much larger rationals, yet independently:

```ruby
h3.to_r
 => (37897/52234)
```

Therefore, even without increasing the size of each individual prime, we can homomorphically represent very large rationals by considering more primes in the g-adic system:

```ruby
rat4 = Rational(84245698732457344123,198437243845987593234524
primes = [349, 353, 359, 367, 373, 379, 383, 389, 397, 401, 409]
h4 = HenselCode::TruncatedFiniteGadicExpansion.new primes, r, rat4
# => HenselCode: [16442637, 10524943, 2432723, 10742241, 37389750, 10164016, 7690494, 32341841, 26459590, 50463786, 28362831]>
h4.to_r
# => (84245698732457344123/198437243845987593234524)
```

## Finite-segment g-adic Hensel codes

### Description
The finite-segment g-adic Hensel codes are analogous to the relationship between truncated finite p-adic expansions and finite p-adic expansions. With the finite-segement g-adic Hensel codes, we have a collection of fixed-degree univariate polynomials for each one of `k` distinct primes used to compute a g-adic Hensel code. 

### Unique Benefits

Finite-segement g-adic Hensel codes combine the best of two worlds: multiple independent Hensel codes which can be computed in parallel / in a distributed manner and computations using fixed-degree polynomials where for each `b`-bit prime `p_i`, the maximum expansion of all computations will take at most `1 + 2b` bits. Combining parallel/distributed computation with minimal computation expansion can be beneficial for a number of applications including massive parallel computations and egde computing. 

### Usage
```ruby
primes = [241, 251, 257]
r = 3
rat1 = Rational(2,3)
rat2 = Rational(5,9)
h1 = HenselCode::FiniteGadicExpansion.new primes, r, rat1
# => <HenselCode: ["81 + 80p + 80p^2", "168 + 83p + 167p^2", "172 + 85p + 171p^2"]>
h2 = HenselCode::FiniteGadicExpansion.new primes, r, rat2
# => <HenselCode: ["188 + 26p + 107p^2", "140 + 111p + 139p^2", "229 + 199p + 142p^2"]>
h1.to_r
# => (2/3)
h2.to_r
# => (5/9)
h1.to_a
# => [[81, 80, 80], [168, 83, 167], [172, 85, 171]]
h2.to_a
# => [[188, 26, 107], [140, 111, 139], [229, 199, 142]]
```

### Arithmetic
```ruby
h1_plus_h2 = h1 + h2
# => <HenselCode: ["28 + 107p + 187p^2", "57 + 195p + 55p^2", "144 + 28p + 57p^2"]>
h1_minus_h2 = h1 - h2
# => <HenselCode: ["134 + 53p + 214p^2", "28 + 223p + 27p^2", "200 + 142p + 28p^2"]>
h1_times_h2 = h1 * h2
# => <HenselCode: ["45 + 98p + 71p^2", "177 + 241p + 92p^2", "67 + 133p + 9p^2"]>
h1_div_h2 = h1 / h2
# => <HenselCode: ["194 + 192p + 192p^2", "202 + 200p + 200p^2", "104 + 51p + 154p^2"]>
h2.inverse
# => <HenselCode: ["50 + 48p + 48p^2", "52 + 50p + 50p^2", "156 + 205p + 102p^2"]>
h1 * h2.inverse
# => <HenselCode: ["194 + 192p + 192p^2", "202 + 200p + 200p^2", "104 + 51p + 154p^2"]>
h2 * h2.inverse
# => <HenselCode: ["1 + 0p + 0p^2", "1 + 0p + 0p^2", "1 + 0p + 0p^2"]>
```

and we can check that

```ruby
h1_plus_h2.to_r
# => (11/9)
rat1 + rat2
# => (11/9)
h1_minus_h2.to_r
# => (1/9)
rat1 - rat2
# => (1/9)
h1_times_h2.to_r
# => (10/27)
rat1 * rat2
# => (10/27)
h1_div_h2.to_r
# => (6/5)
rat1 / rat2
# => (6/5)
```

## Class Aliases

Since some classes can have long names, here are some aliases that can be used for keeping the lines of code shorter:

- `HenselCode::TruncatedFinitePadicExpansion` => `HenselCode::TFPE`
- `HenselCode::HenselCodesWithDifferentPrimesAndExponents` => `HenselCode::HCWDPAE`
- `HenselCode::WrongHenselCodeInputType` => `HenselCode::WHIT`

## Coming Soon

There are many types of Hensel codes. We are currently implementing only one. Very soon we will add more types of Hensel codes to the library, which will further expand what we can do with it.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/davidwilliam/hensel_code.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).