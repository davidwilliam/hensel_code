# frozen_string_literal: true

module HenselCode
  # truncated finite p-adic expansion hensel code class
  class TruncatedFinitePadicExpansion < PAdicBase
    def modulus
      prime**exponent
    end

    def to_i
      hensel_code
    end

    def to_s
      hensel_code.to_s
    end

    def inspect
      "[HenselCode: #{hensel_code}, prime: #{prime}, exponent: #{exponent}, modulus: #{modulus}]"
    end

    private

    def evaluate(operation, other)
      if operation == "/"
        other_hensel_code = mod_inverse(other.hensel_code, modulus)
        op = "*"
      else
        other_hensel_code = other.hensel_code
        op = operation
      end
      self.class.new prime, exponent, hensel_code.send(op, other_hensel_code) % modulus
    end

    def valid_number?(number)
      case number
      when Rational
        @rational = number
      when Integer
        @hensel_code = number
        decode
      else
        raise WrongHenselCodeInputType, "number must be a Rational or an\
                                        Integer object and it was a #{number.class}"
      end
    end

    def valid_hensel_code?(new_hensel_code)
      message = "must be an integer up to #{modulus - 1}"
      raise WrongHenselCodeInputType, message unless new_hensel_code < modulus
    end

    def encode
      denominator_inverse = mod_inverse(denominator, modulus)
      @hensel_code = (numerator * denominator_inverse) % modulus
    end

    def decode
      eea_vars = eea_core(modulus, hensel_code, n)
      i, x, y = eea_vars[2..4]
      @rational = Rational(*[x, y].map { |e| ((-1)**(i + 1)) * e })
    end
  end
end
