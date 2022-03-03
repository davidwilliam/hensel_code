# frozen_string_literal: true

module HenselCode
  # verifications pre-evaluation of hensel codes
  module TFPEVerifier
    def valid?(other)
      incompatible_operand_type?(other)
      different_prime_and_same_exponent?(other)
      different_prime_and_different_exponent?(other)
      same_prime_and_different_exponent?(other)
    end

    def incompatible_operand_type?(other)
      message = "#{self} is a #{self.class} while #{other} is a #{other.class}"
      raise IncompatibleOperandTypes, message unless instance_of?(other.class)
    end

    def different_prime_and_same_exponent?(other)
      message = "#{self} has prime #{prime} while #{other} has prime #{other.prime}"
      raise HenselCodesWithDifferentPrimes, message if prime != other.prime && exponent == other.exponent
    end

    def different_prime_and_different_exponent?(other)
      message = <<~MSG
        "#{self} has prime #{prime} and exponent #{exponent}
        while #{other} has prime #{other.prime} and exponent #{other.exponent}
      MSG
      raise HenselCodesWithDifferentPrimesAndExponents, message if prime != other.prime && exponent != other.exponent
    end

    def same_prime_and_different_exponent?(other)
      message = "#{self} has exponent #{exponent} while #{other} has exponent #{other.exponent}"
      raise HenselCodesWithDifferentExponents, message if prime == other.prime && exponent != other.exponent
    end
  end
end
