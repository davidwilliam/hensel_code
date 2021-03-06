# frozen_string_literal: true

module HenselCode
  # verifications pre-evaluation of hensel codes
  module GAdicVerifier
    def valid?(other)
      incompatible_operand_type?(other)
      different_primes_and_same_exponent?(other)
      different_primes_and_different_exponent?(other)
      same_primes_and_different_exponent?(other)
    end

    def incompatible_operand_type?(other)
      message = "#{self} is a #{self.class} while #{other} is a #{other.class}"
      raise IncompatibleOperandTypes, message unless instance_of?(other.class)
    end

    def different_primes_and_same_exponent?(other)
      message = "#{self} has primes #{primes} while #{other} has prime #{other.primes}"
      raise HenselCodesWithDifferentPrimes, message if primes != other.primes && exponent == other.exponent
    end

    def different_primes_and_different_exponent?(other)
      message = <<~MSG
        "#{self} has prime #{primes} and exponent #{exponent}
        while #{other} has prime #{other.primes} and exponent #{other.exponent}
      MSG
      raise HenselCodesWithDifferentPrimesAndExponents, message if primes != other.primes && exponent != other.exponent
    end

    def same_primes_and_different_exponent?(other)
      message = "#{self} has exponent #{exponent} while #{other} has exponent #{other.exponent}"
      raise HenselCodesWithDifferentExponents, message if primes == other.primes && exponent != other.exponent
    end
  end
end
