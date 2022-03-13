# frozen_string_literal: true

require "test_helper"

class TestPolynomialValidations < Minitest::Test
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

  def test_argument_error
    coefficients = random_distinct_numbers("integer", @exponent, 8)

    assert_raises(ArgumentError, "prime can't be nil") { HenselCode::Polynomial.new nil, coefficients }
    assert_raises(ArgumentError, "coefficients can't be nil") { HenselCode::Polynomial.new @prime, nil }
    assert_raises(ArgumentError, "prime must be an integer") { HenselCode::Polynomial.new Rational(7, 2), coefficients }
    assert_raises(ArgumentError, "coefficients must be an array") { HenselCode::Polynomial.new @prime, @prime + 1 }
    assert_raises(ArgumentError, "coefficients must be an array of integers") { HenselCode::Polynomial.new @prime, [] }
  end

  def test_operands_error
    coefficients1 = random_distinct_numbers("integer", 5, 8)
    coefficients2 = random_distinct_numbers("integer", 9, 8)
    f1 = HenselCode::Polynomial.new 257, coefficients1
    f2 = HenselCode::Polynomial.new 257, coefficients2
    f3 = HenselCode::Polynomial.new 251, coefficients1

    ["+", "-", "*", "/"].each do |op|
      assert_raises(HenselCode::WHIT, "polynomials must have same degree") { f1.send(op, f2) }
      assert_raises(HenselCode::WHIT, "polynomials must have same prime") { f1.send(op, f3) }
    end
  end
end
