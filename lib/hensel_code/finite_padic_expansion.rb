# frozen_string_literal: true

module HenselCode
  # finite p-adic expansion hensel code class
  class FinitePadicExpansion < PAdicBase
    def modulus
      prime
    end

    def to_a
      hensel_code
    end

    def to_truncated
      TruncatedFinitePadicExpansion.new(prime, exponent, rational)
    end

    def to_s
      hensel_code.map.with_index do |h, i|
        "#{h}#{polynomial_variable(i)}"
      end.join(" + ")
    end

    def inspect
      "[HenselCode: #{polynomial_form}, prime: #{prime}, exponent: #{exponent}, modulus: #{modulus}]"
    end

    private

    def evaluate(operation, other)
      h_ = to_truncated.send(operation, other.to_truncated).hensel_code
      new_hensel_code = (0..exponent - 1).map { |i| h_ / (prime**i) % prime }
      self.class.new prime, exponent, new_hensel_code
    end

    def polynomial_variable(index)
      i = index > 1 ? 2 : index
      ["", "p", "p^#{index}"][i]
    end

    def polynomial_form
      to_s
    end

    def valid_number?(number)
      if number.is_a?(Rational)
        @rational = number
      elsif number.is_a?(Array) && number.map(&:class).uniq == [Integer] && number.size == exponent
        @hensel_code = number
        decode
      else
        message = "number must be a Rational or an\
        Array of integers of size #{exponent}"
        raise WrongHenselCodeInputType, message
      end
    end

    def valid_hensel_code?(new_hensel_code)
      conditions = [
        new_hensel_code.is_a?(Array),
        new_hensel_code.map(&:class).uniq == [Integer],
        new_hensel_code.size == exponent
      ]
      message = "must be an array of integers of size #{exponent}"
      raise WrongHenselCodeInputType, message unless conditions.uniq == [true]
    end

    def encode
      h_ = TruncatedFinitePadicExpansion.new(prime, exponent, rational).hensel_code
      @hensel_code = (0..exponent - 1).map { |i| h_ / (prime**i) % prime }
    end

    def decode
      number = 0
      hensel_code.each_with_index { |d, i| number += d * (prime**i) }
      @rational = TruncatedFinitePadicExpansion.new(prime, exponent, number).to_r
    end
  end
end
