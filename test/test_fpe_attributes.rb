# frozen_string_literal: true

require "test_helper"

class TestFPEAttributes < Minitest::Test
  include HenselCode::Tools

  def setup
    @prime = random_prime(8)
    @exponent = rand(2..6)
    @n = Integer.sqrt(((@prime**@exponent) - 1) / 2)
    # Below, TruncatedFinitePadicExpansion is used instead of FinitePadicExpansion
    # because the only goals is to generate rational numbers fom single integers
    @rationals = (@n + 1..@n + 99).map { |h| HenselCode::TruncatedFinitePadicExpansion.new(@prime, 1, h).to_r }
    @rat1, @rat2 = Array.new(2) { @rationals.sample }
  end

  def test_replace_exponent
    prime = 257
    exponent = 3
    rational = @rationals.sample
    h = HenselCode::FinitePadicExpansion.new prime, exponent, rational

    assert_equal rational, h.to_r
    assert_equal rational, h.replace_exponent(exponent + 2).to_r
  end

  def test_replace_rational
    prime = 257
    exponent = 3
    rat1, rat2 = Array.new(2) { @rationals.sample }
    h = HenselCode::FinitePadicExpansion.new prime, exponent, rat1

    assert_equal rat1, h.to_r
    assert_equal rat2, h.replace_rational(rat2).to_r
  end

  def test_replace_prime
    prime1, prime2 = random_distinct_numbers("prime", 2, 9)
    exponent = 3
    rational = @rationals.sample
    h = HenselCode::FinitePadicExpansion.new prime1, exponent, rational

    assert_equal prime1, h.prime
    assert_equal rational, h.to_r
    assert_equal prime2, h.replace_prime(prime2).prime
    assert_equal rational, h.to_r
  end

  def test_replace_hensel_code
    prime = 257
    exponent = 3
    rat = @rationals.sample
    h = HenselCode::FinitePadicExpansion.new prime, exponent, rat
    replacement = [14, 253, 178, 124]
    message = "must be an array of integers of size #{exponent}"

    assert_equal replacement[0..2], h.replace_hensel_code(replacement[0..2]).hensel_code
    assert_raises(HenselCode::WHIT, message) { h.replace_hensel_code(replacement[0..1]) }
    assert_raises(HenselCode::WHIT, message) { h.replace_hensel_code(replacement) }
  end
end
