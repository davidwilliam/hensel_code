# frozen_string_literal: true

module HenselCode
  # truncated finite g-adic expansion hensel code class
  class TruncatedFiniteGadicExpansion < GAdicBase
    def modululi
      primes.map { |prime| prime**exponent }
    end

    def to_a
      hensel_code.map(&:to_i)
    end

    def to_s
      "#{hensel_code.map(&:to_s)}>"
    end

    def inspect
      "<HenselCode: #{to_a}>"
    end

    def inverse
      new_hensel_code = hensel_code.map(&:inverse)
      self.class.new primes, exponent, new_hensel_code
    end

    private

    def evaluate(operation, other)
      new_hensel_code = hensel_code.zip(other.hensel_code).map { |pair| pair[0].send(operation, pair[1]) }
      self.class.new primes, exponent, new_hensel_code
    end

    def valid_number?(number)
      if number.is_a?(Rational)
        @rational = number
      elsif number.is_a?(Array) && number.map(&:class).uniq == [HenselCode::TruncatedFinitePadicExpansion]
        @hensel_code = number
        decode
      else
        raise WrongHenselCodeInputType, "number must be a Rational or an\
                                        Array of truncated p-adic Hensel codes and it was a #{number.class}"
      end
    end

    def valid_hensel_code?(new_hensel_code)
      condition = new_hensel_code.is_a?(Array) && new_hensel_code.map(&:class).uniq == [HenselCode::TFPE]
      message = "must be an array of truncated p-adic Hensel codes"
      raise WrongHenselCodeInputType, message unless condition
    end

    def encode
      @g = primes.inject(:*)
      @hensel_code = primes.map do |prime|
        TruncatedFinitePadicExpansion.new prime, exponent, rational
      end
    end

    def decode
      h = TruncatedFinitePadicExpansion.new g, exponent, crt(modululi, hensel_code.map(&:to_i))
      @rational = h.to_r
    end
  end
end
