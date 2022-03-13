# frozen_string_literal: true

require "test_helper"

class TestTruncatedFiniteGadicExpansion < Minitest::Test
  include HenselCode::Tools

  def setup
    @exponent = 3
    @primes = [257, 263, 269]
    @g = @primes.inject(:*)
    @n = Integer.sqrt(((@g**@exponent) - 1) / 2)
    @rationals = [1, 2, 4, 5, 7, 8, 11].map { |i| Rational(i, 3) }
    @rat1, @rat2 = Array.new(2) { @rationals.sample }
  end

  def test_create_hensel_code
    rational = @rationals.sample
    h = HenselCode::TruncatedFiniteGadicExpansion.new @primes, @exponent, rational

    assert_equal HenselCode::TruncatedFiniteGadicExpansion, h.class
    assert_equal @primes, h.primes
    assert_equal @exponent, h.exponent
    assert_equal @n, h.n
    assert_equal [HenselCode::TruncatedFinitePadicExpansion], h.hensel_code.map(&:class).uniq
  end

  def test_encode_decode
    rational = @rationals.sample
    h1 = HenselCode::TruncatedFiniteGadicExpansion.new @primes, @exponent, rational
    h2 = HenselCode::TruncatedFiniteGadicExpansion.new @primes, @exponent, h1.hensel_code

    assert_equal rational, h1.rational
    assert_equal rational, h1.to_r
    assert_equal rational, h2.to_r
  end

  def test_to_s
    rational = @rationals.sample
    h = HenselCode::TruncatedFiniteGadicExpansion.new @primes, @exponent, rational
    expected_to_s = "#{h.hensel_code.map(&:to_s)}>"

    assert_equal expected_to_s, h.to_s
  end

  def test_replace_exponent
    exponent = 3
    rational = @rationals.sample
    h = HenselCode::TruncatedFiniteGadicExpansion.new @primes, exponent, rational

    assert_equal rational, h.to_r
    assert_equal rational, h.replace_exponent(exponent + 2).to_r
  end

  def test_replace_rational
    exponent = 3
    rat1, rat2 = Array.new(2) { @rationals.sample }
    h = HenselCode::TruncatedFiniteGadicExpansion.new @primes, exponent, rat1

    assert_equal rat1, h.to_r
    assert_equal rat2, h.replace_rational(rat2).to_r
  end

  def test_replace_primes
    exponent = 3
    primes1 = [313, 317, 331]
    primes2 = [367, 373, 379]
    rational = @rationals.sample
    h = HenselCode::TruncatedFiniteGadicExpansion.new primes1, exponent, rational

    assert_equal primes1, h.primes
    assert_equal rational, h.to_r
    assert_equal primes2, h.replace_primes(primes2).primes
    assert_equal rational, h.to_r
  end

  def test_replace_hensel_code
    rat1, rat2 = random_distinct_numbers("rational", @exponent, 8)
    h1 = HenselCode::TruncatedFiniteGadicExpansion.new @primes, @exponent, rat1
    h2 = HenselCode::TruncatedFiniteGadicExpansion.new @primes, @exponent, rat2

    assert_equal rat1, h1.to_r
    assert_equal rat2, h2.to_r
    assert_equal rat1, h2.replace_hensel_code(h1.hensel_code).to_r
  end

  def test_inspect
    rational = @rationals.sample
    h = HenselCode::TruncatedFiniteGadicExpansion.new @primes, @exponent, rational
    expected_inspect = "<HenselCode: #{h.hensel_code.map(&:to_i)}>"

    assert_equal expected_inspect, h.inspect
  end

  def test_inverse
    rational = Rational(2, 3)
    h = HenselCode::TruncatedFiniteGadicExpansion.new @primes, @exponent, rational

    assert_equal rational**-1, h.inverse.to_r
    assert_equal 1, (h * h.inverse).to_r
  end
end
