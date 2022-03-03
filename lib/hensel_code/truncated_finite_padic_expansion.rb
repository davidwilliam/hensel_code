module HenselCode
  class TruncatedFinitePadicExpansion
    include Tools

    attr_accessor :prime, :exponent, :rational, :hensel_code, :n

    def initialize(prime, exponent, number)
      @prime = prime
      @exponent = exponent
      @n = Integer.sqrt((modulus - 1)/2)

      if number.is_a?(Rational)
        @rational = number
      elsif number.is_a?(Integer)
        @hensel_code = number
        decode
      else
        raise WrongHenselCodeInputType.new "number must be a Rational or an Integer object and it was a #{number.class}"
      end
      encode
    end

    def modulus
      prime**exponent
    end

    def numerator
      rational.numerator
    end

    def denominator
      rational.denominator
    end

    def to_r
      decode
      rational
    end

    def to_i
      hensel_code
    end

    def to_s
      hensel_code.to_s
    end

    def replace_prime(new_prime)
      self.prime = new_prime
      encode
      decode
      self
    end

    def replace_exponent(new_exponent)
      self.exponent = new_exponent
      encode
      decode
      self
    end

    def replace_rational(new_rational)
      self.rational = new_rational
      encode
      decode
      self
    end

    def + h2
      valid?(h2)
      self.class.new prime, exponent, (hensel_code + h2.hensel_code) % modulus
    end

    def - h2
      valid?(h2)
      self.class.new prime, exponent, (hensel_code - h2.hensel_code) % modulus
    end

    def * h2
      valid?(h2)
      self.class.new prime, exponent, (hensel_code * h2.hensel_code) % modulus
    end

    def / h2
      valid?(h2)
      h2_hensel_code_inverse = mod_inverse(h2.hensel_code, modulus)
      self.class.new prime, exponent, (hensel_code * h2_hensel_code_inverse) % modulus
    end

    private

    def encode
      denominator_inverse = mod_inverse(denominator,modulus)
      @hensel_code = (numerator * denominator_inverse) % modulus
    end

    def decode
      eea_vars = eea_core(modulus, hensel_code, n)
      i, x, y = eea_vars[3..5]
      @rational = Rational(*[x,y].map{|e| (-1)**(i + 1) * e})
    end

    def valid?(h2)
      if self.class == h2.class
        if prime != h2.prime && exponent == h2.exponent
          message = "#{self} has prime #{prime} while #{h2} has prime #{h2.prime}"
          raise HenselCodesWithDifferentPrimes.new message
        elsif prime != h2.prime && exponent != h2.exponent
          message = "#{self} has prime #{prime} and exponent #{exponent} while #{h2} has prime #{h2.prime} and exponent #{h2.exponent}"
          raise HenselCodesWithDifferentPrimesAndExponents.new message
        elsif prime == h2.prime && exponent != h2.exponent
          message = "#{self} has exponent #{exponent} while #{h2} has exponent #{h2.exponent}"
          raise HenselCodesWithDifferentExponents.new message
        end
      else
        message = "#{self} is a #{self.class} while #{h2} is a #{h2.class}"
        raise IncompatibleOperandTypes.new message
      end
    end

  end
end