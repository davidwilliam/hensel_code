# HenselCode

![example workflow](https://github.com/davidwilliam/hensel_code/actions/workflows/main.yml/badge.svg) [![codecov](https://codecov.io/gh/davidwilliam/hensel_code/branch/main/graph/badge.svg?token=XJ0C0U7P2M)](https://codecov.io/gh/davidwilliam/hensel_code) [![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop) ![GitHub](https://img.shields.io/github/license/davidwilliam/hensel_code)

Hensel Code allows you to homomorphically encode rational numbers as integers using the finite-segment p-adic arithmetic, also known as Hensel codes. 

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

## Usage

Let `p=257` and `r=3`. Given two rational numbers `rat1 = Rational(3,5)` and `rat2 = Rational(4,3)`, we encode `rat1` and `rat2` as follows:

```ruby
h1 = HenselCode::TruncatedFinitePadicExpansion.new(p, r, rat1)
# => [HenselCode: 13579675, prime: 257, exponent: 3, modulus: 16974593]
h2 = HenselCode::TruncatedFinitePadicExpansion.new(p, r, rat1)
# => [HenselCode: 5658199, prime: 257, exponent: 3, modulus: 16974593]
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
h1_minus_h2 = h1 - h2
h1_times_h2 = h1 * h2
h1_div_h2 = h1 / h2
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
```

### Constraints

In order to operate on two or more Hensel codes, they all must be of the same object type and have the same prime and exponent, otherwise HenselCode will raise an exception. Again, let `rat1 = Rational(3,5)` and `rat2 = Rational(4,3)`, and `p1 = 241`, `p2 = 251`, `r1 = 3`, and `r2 = 4`:

```ruby
h1 = HenselCode::TruncatedFinitePadicExpansion.new(p1, r1, rat1)
# => [HenselCode: 5599009, prime: 241, exponent: 3, modulus: 13997521]
h2 = HenselCode::TruncatedFinitePadicExpansion.new(p1, r2, rat1)
# => [HenselCode: 1349361025, prime: 241, exponent: 4, modulus: 3373402561]
h3 = HenselCode::TruncatedFinitePadicExpansion.new(p2, r1, rat1)
# => [HenselCode: 6325301, prime: 251, exponent: 3, modulus: 15813251]
h4 = HenselCode::TruncatedFinitePadicExpansion.new(p2, r2, rat1)
=> [HenselCode: 1587650401, prime: 251, exponent: 4, modulus: 3969126001]
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
# => [HenselCode: 126672339, prime: 541, exponent: 3, modulus: 158340421]
```

We can change the prime and the exponent:

```ruby
p = 1223
r = 4
h.replace_prime(p)
# => [HenselCode: 731710629, prime: 1223, exponent: 3, modulus: 1829276567]
h.replace_exponent(r)
# => [HenselCode: 1789764193155, prime: 1223, exponent: 4, modulus: 2237205241441]
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
# => [HenselCode: 1278402995111, prime: 1223, exponent: 4, modulus: 2237205241441]
h.to_r
# => (13/7)
```

We can initiate a Hensel code object with its Hensel code value, instead of a rational number:

```ruby
h = HenselCode::TruncatedFinitePadicExpansion.new p, r, 53673296543
```

and then we can check what is the rational number represented by the resulting object:

```ruby
h.to_r
# => (706147/633690)
```

We can update the Hensel code value of an existing Hensel code object:

```ruby
h.replace_hensel_code(38769823656)
# => (-685859/94809)
```

### Class Alias

Since `HenselCode::TruncatedFinitePadicExpansion` is a bit long, the alias `HenselCode::TFPE` can be used instead.

## Coming Soon

There are many types of Hensel codes. We are currently implementing only one. Very soon we will add more types of Hensel codes to the library, which will further expand what we can do with it.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/davidwilliam/hensel_code.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
