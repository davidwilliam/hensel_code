# frozen_string_literal: true

require "test_helper"

class TestFPEArithmetic < Minitest::Test
  include HenselCode::Tools

  def setup
    @prime = random_prime(9)
    @exponent = 3
    @exponent2 = @exponent + 1
    @n = Integer.sqrt(((@prime**@exponent) - 1) / 2)
    @rationals = (@n + 1..@n + 99).map { |h| HenselCode::TruncatedFinitePadicExpansion.new(@prime, 1, h).to_r }
    @rat1, @rat2 = Array.new(2) { @rationals.sample }
  end

  def test_valid_operation_properties
    rat1, rat2 = Array.new(2) { @rationals.sample }
    h1 = HenselCode::FinitePadicExpansion.new @prime, @exponent, rat1
    h2 = HenselCode::FinitePadicExpansion.new @prime, @exponent, rat2

    ["+", "-", "*", "/"].each do |operation|
      h3 = h1.send(operation, h2)

      assert_equal HenselCode::FinitePadicExpansion, h3.class
      assert_equal @prime, h3.prime
      assert_equal @exponent, h3.exponent
    end
  end

  def test_valid_operation_evaluation
    rat1 = Rational(2, 3)
    rat2 = Rational(3, 5)
    h1 = HenselCode::FinitePadicExpansion.new @prime, 7, rat1
    h2 = HenselCode::FinitePadicExpansion.new @prime, 7, rat2

    ["+", "-", "*", "/"].each do |operation|
      h3 = h1.send(operation, h2)
      # puts "operation = #{operation}"

      assert_equal rat1.send(operation, rat2), h3.to_r
    end
  end
end
