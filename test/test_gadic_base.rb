# frozen_string_literal: true

require "test_helper"

class TestGAdicBase < Minitest::Test
  include HenselCode::Tools

  def setup
    @prime = random_prime(16)
    @exponent = 3
    @primes = random_distinct_numbers("prime", @exponent, 9)
    @g = @primes.inject(:*)
    @n = Integer.sqrt(((@g**@exponent) - 1) / 2)
    @rationals = (1..100).map { |i| Rational(i, i + 1) }
    @rat1, @rat2 = Array.new(2) { @rationals.sample }
  end

  def test_numerator
    rat = @rationals.sample
    h = HenselCode::TruncatedFiniteGadicExpansion.new @primes, @exponent, rat

    assert_equal rat.numerator, h.numerator
  end

  def test_denominator
    rat = @rationals.sample
    h = HenselCode::TruncatedFiniteGadicExpansion.new @primes, @exponent, rat

    assert_equal rat.denominator, h.denominator
  end
end
