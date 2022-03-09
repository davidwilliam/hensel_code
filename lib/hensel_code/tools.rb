# frozen_string_literal: true

module HenselCode
  # Required basics of number generation and modular
  module Tools
    def random_integer(bits)
      OpenSSL::BN.rand(bits).to_i
    end

    def random_rational(bits)
      numbers = [random_integer(bits)]
      while numbers.size < 2
        num = random_integer(bits)
        numbers << num if numbers.last.gcd(num) == 1
      end
      Rational(*numbers)
    end

    def random_prime(bits)
      # The OpenSSL library only generates random primes from 16 bits on
      # The 3513 is the first 16-bit number
      # which means there are 3512 primes under 16 bits in length
      # Therefore for allowing values for the parameter 'bits' between 2 and 15,
      # we generate all primes from 2 to 15 bits using Ruby's Prime library
      # and select only those with bit length equal to the value of 'bits'
      # so we sample one element
      # We only do this if the value of 'bits' is less than 16, otherwise we
      # use OpenSSL to generate the prime
      if bits >= 2 && bits < 16
        primes = Prime.first(3512)
        primes.select { |p| p.bit_length == bits }.sample
      elsif bits >= 16
        OpenSSL::BN.generate_prime(bits).to_i
      else
        raise BadBitRangeForRandomPrime, "The bit length must be greater than or equal to 2"
      end
    end

    def random_distinct_integers(quantity, bits)
      integers = [random_integer(bits)]
      while integers.size < quantity
        integer = random_integer(bits)
        integers << integer if integer != integers.last
      end
      integers
    end

    def random_distinct_primes(quantity, bits)
      primes = [random_prime(bits)]
      while primes.size < quantity
        prime = random_prime(bits)
        primes << prime if prime != primes.last
      end
      primes
    end

    def eea_core(num1, num2, bound = 0)
      setup = bound.zero? ? [1, 0] : [0, 1]
      x0, x1, y0, y1 = [num1, num2] + setup
      i = 1
      while x1 > bound
        q = x0 / x1
        x0, x1 = x1, x0 - (q * x1)
        y0, y1 = y1, y0 - (q * y1)
        i += 1
      end
      [x0, y0, i, x1, y1]
    end

    def extended_gcd(num1, num2)
      if num1.negative?
        x, y = extended_gcd(-num1, num2)
        [x, -y]
      elsif num2.negative?
        x, y = extended_gcd(num1, -num2)
        [x, y]
      else
        x, y = eea_core(num1, num2)
        [x, y]
      end
    end

    def mod_inverse(num, mod)
      x, y, = extended_gcd(num, mod)
      raise ZeroDivisionError, "#{num} has no inverse modulo #{mod}" unless x == 1

      y % mod
    end

    def modular_cauchy_product(prime, coefficients1, coefficients2)
      sum_of_coefficients_sizes = coefficients1.size + coefficients2.size
      res, res_, carry, row = multiplication_setup
      coefficients1.product(coefficients2).each_with_index do |x,i|
        res += [0] * (coefficients1.size - 1 - row) if (i % coefficients1.size) == 0
        carry, result = mul_carry(prime, carry, x[0], x[1])
        res_ << result
        if (i % coefficients1.size) == (coefficients1.size - 1)
          res_, res, carry, row = multiplication_checkpoint(res_, res, carry, row)
        end
      end
      carry = 0
      new_coefficients = []
      res.reverse.each_slice(sum_of_coefficients_sizes).to_a.transpose.each do |x| 
        new_coefficients << ((carry + x.reduce(:+)) % prime)
        carry = (carry + x.reduce(:+)) / prime
      end
      new_coefficients[0..coefficients1.size - 1]
    end

    def cauchy_product(prime, coefficients1, coefficients2)
      product = []
      carry = 0
      (0..coefficients1.size - 1).each do |i|
        sum = 0
        carry_ = 0
        (0..i).each do |j|
          sum += (coefficients1[j] * coefficients2[i - j])
        end
        product << (carry + sum) % prime
        carry = (carry + sum) / prime
      end
      product
    end

    private

    def multiplication_setup
      [[], [], 0, 0]
    end

    def multiplication_checkpoint(res_, res, carry, row)
      res_ << carry
      res_.reverse!
      res += res_
      res_ = []
      carry = 0
      res += [0] * row
      row += 1
      [res_, res, carry, row]
    end

    def mul_carry(prime, carry, op1, op2)
      [(carry + op1 * op2) / prime, (carry + op1 * op2) % prime]
    end
  end
end
