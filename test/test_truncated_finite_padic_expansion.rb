# frozen_string_literal: true

require "test_helper"

class TestTruncatedFinitePadicExpansion < Minitest::Test
  include HenselCode::Tools

  def setup
    @prime = random_prime(8)
    @exponent = rand(2..6)
    @n = Integer.sqrt(((@prime**@exponent) - 1) / 2)
    @rationals = (0..@prime / 2).map { |h| HenselCode::TruncatedFinitePadicExpansion.new(@prime, @exponent, h).to_r }
    @rat1, @rat2 = Array.new(2) { @rationals.sample }
  end

  def test_create_hensel_code
    rational = @rationals.sample
    h = HenselCode::TruncatedFinitePadicExpansion.new @prime, @exponent, rational

    assert_equal HenselCode::TruncatedFinitePadicExpansion, h.class
    assert_equal @prime, h.prime
    assert_equal @exponent, h.exponent
    assert_equal @n, h.n
    assert_equal Integer, h.hensel_code.class
    assert_equal Integer, h.to_i.class
  end

  def test_encode_decode
    rational = @rationals.sample
    h = HenselCode::TruncatedFinitePadicExpansion.new @prime, @exponent, rational

    assert_equal rational, h.rational
    assert_equal rational, h.to_r
  end

  def test_to_s
    rational = @rationals.sample
    h = HenselCode::TruncatedFinitePadicExpansion.new @prime, @exponent, rational

    assert_equal h.hensel_code.to_s, h.to_s
  end

  def test_replace_exponent
    prime = 257
    exponent = 3
    rational = @rationals.sample
    h = HenselCode::TruncatedFinitePadicExpansion.new prime, exponent, rational

    assert_equal rational, h.to_r
    assert_equal rational, h.replace_exponent(exponent + 2).to_r
  end

  def test_replace_rational
    prime = 257
    exponent = 3
    rat1, rat2 = Array.new(2) { @rationals.sample }
    h = HenselCode::TruncatedFinitePadicExpansion.new prime, exponent, rat1

    assert_equal rat1, h.to_r
    assert_equal rat2, h.replace_rational(rat2).to_r
  end

  def test_replace_prime
    prime1, prime2 = random_distinct_primes(2, 9)
    exponent = 3
    rational = @rationals.sample
    h = HenselCode::TruncatedFinitePadicExpansion.new prime1, exponent, rational

    assert_equal prime1, h.prime
    assert_equal rational, h.to_r
    assert_equal prime2, h.replace_prime(prime2).prime
    assert_equal rational, h.to_r
  end
end
