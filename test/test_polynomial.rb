# frozen_string_literal: true

require "test_helper"

class TestPolynomial < Minitest::Test
  include HenselCode::Tools
  include HenselCode::ModularArithmetic

  def setup
    @prime = 257
    @exponent = 3
    @exponent2 = @exponent + 1
    @n = Integer.sqrt(((@prime**@exponent) - 1) / 2)
    x = 0
    y = 1
    @rationals = (1..100).map { |i| Rational(x + i, y + i) }
    @rat1, @rat2 = Array.new(2) { @rationals.sample }
  end

  def test_initialize
    coefficients = random_distinct_numbers("integer", @exponent, 8)
    f = HenselCode::Polynomial.new @prime, coefficients

    assert_equal HenselCode::Polynomial, f.class
    assert_equal @prime, f.prime
    assert f.fixed_length
    assert_equal coefficients, f.coefficients
  end

  def test_degree
    coefficients1 = random_distinct_numbers("integer", 5, 8)
    coefficients2 = random_distinct_numbers("integer", 9, 8)
    f1 = HenselCode::Polynomial.new @prime, coefficients1
    f2 = HenselCode::Polynomial.new @prime, coefficients2

    assert_equal 4, f1.degree
    assert_equal 8, f2.degree
  end

  def test_to_s
    f = HenselCode::Polynomial.new @prime, [2, 3, 4]
    expected_f_to_s = "2 + 3p + 4p^2"

    assert_equal expected_f_to_s, f.to_s
  end

  def test_inspect
    f = HenselCode::Polynomial.new @prime, [2, 3, 4]
    expected_f_inspect = "<Polynomial: 2 + 3p + 4p^2>"

    assert_equal expected_f_inspect, f.inspect
  end
end
