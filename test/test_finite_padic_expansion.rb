# frozen_string_literal: true

require "test_helper"

class TestFinitePadicExpansion < Minitest::Test
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

  def test_create_hensel_code
    rational = @rationals.sample
    h = HenselCode::FinitePadicExpansion.new @prime, @exponent, rational
    properties = [@prime, @exponent, @n]

    assert_equal HenselCode::FinitePadicExpansion, h.class
    assert_equal properties, [h.prime, h.exponent, h.n]
    assert_equal [Array], [h.hensel_code.class, h.to_a.class].uniq
  end

  def test_hensel_polynomial
    rational = @rationals.sample
    h = HenselCode::FinitePadicExpansion.new @prime, @exponent, rational

    assert_equal HenselCode::Polynomial, h.polynomial.class
    assert_equal h.hensel_code, h.polynomial.coefficients
  end

  def test_encode_decode
    rational = @rationals.sample
    h = HenselCode::FinitePadicExpansion.new @prime, @exponent, rational

    assert_equal rational, h.rational
    assert_equal Array, h.hensel_code.class
    assert_equal [Integer], h.hensel_code.map(&:class).uniq
    assert_equal rational, h.to_r
  end

  def test_to_s
    rational = Rational(19, 25)
    prime = 257
    exponent1 = 3
    exponent2 = 5
    h1 = HenselCode::FinitePadicExpansion.new prime, exponent1, rational
    h2 = HenselCode::FinitePadicExpansion.new prime, exponent2, rational
    expected_string1 = "83 + 195p + 174p^2"
    expected_string2 = "83 + 195p + 174p^2 + 61p^3 + 82p^4"

    assert_equal expected_string1, h1.to_s
    assert_equal expected_string2, h2.to_s
  end

  def test_inspect
    prime = random_prime(9)
    exponent = 3
    rational = Rational(2, 3)
    h = HenselCode::FinitePadicExpansion.new prime, exponent, rational
    h_polynomial = h.send(:polynomial_form)
    expected = "<HenselCode: #{h_polynomial}>"

    assert_equal expected, h.inspect
  end

  def test_to_truncated
    prime = 257
    exponent = 3
    rational = Rational(2, 3)
    h = HenselCode::FinitePadicExpansion.new prime, exponent, rational
    expected_hensel_code = 11_316_396
    assert_equal expected_hensel_code, h.to_truncated.hensel_code
  end

  def test_inverse
    prime = 257
    exponent = 4
    h = HenselCode::FinitePadicExpansion.new prime, exponent, Rational(7, 5)

    assert_equal h.to_r**-1, h.inverse.to_r
    assert_equal 1, (h * h.inverse).to_r
  end

  def test_rational_to_padic_digits
    rational = Rational(2, 3)
    h = HenselCode::FinitePadicExpansion.new 5, 5, rational
    expected_digits = [4, 1, 3, 1, 3]

    assert_equal expected_digits, h.send(:rational_to_padic_digits)
  end

  def test_reduce_rational_in_terms_of_prime
    prime = 5
    rat1 = Rational(2, 15)
    rat2 = Rational(-10, 3)
    rat3 = Rational(4, 3)
    h = HenselCode::FinitePadicExpansion.new prime, 5, rat3

    assert_equal Rational(2, 3), h.send(:reduce_rational_in_terms_of_prime, rat1)
    assert_equal Rational(-2, 3), h.send(:reduce_rational_in_terms_of_prime, rat2)
    assert_equal rat3, h.send(:reduce_rational_in_terms_of_prime, rat3)
  end

  def test_rational_to_integer
    h1 = HenselCode::FinitePadicExpansion.new @prime, @exponent, @rat1
    expected_integer_one = (@rat1.numerator * h1.mod_inverse(@rat1.denominator, @prime)) % @prime
    expected_integer_two = (@rat2.numerator * h1.mod_inverse(@rat2.denominator, @prime)) % @prime

    assert_equal expected_integer_one, h1.send(:rational_to_integer, @rat1)
    assert_equal expected_integer_two, h1.send(:rational_to_integer, @rat2)
  end
end
