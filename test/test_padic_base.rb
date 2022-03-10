# frozen_string_literal: true

require "test_helper"

class TestPAdicBase < Minitest::Test
  include HenselCode::Tools

  def setup
    @prime = random_prime(16)
    @exponent = 3
    @exponent2 = @exponent + 1
    @n = Integer.sqrt(((@prime**@exponent) - 1) / 2)
    x = 0
    y = 1
    @rationals = (1..100).map { |i| Rational(x + i, y + i) }
    @rat1, @rat2 = Array.new(2) { @rationals.sample }
  end

  def test_direct_intilization
    rat = @rationals.sample
    message = "HenselCode::PAdicBase can only be inherited."

    assert_raises(HenselCode::NonInitializableClass, message) do
      HenselCode::PAdicBase.new @prime, @exponent, rat
    end
  end
end
