# frozen_string_literal: true

module HenselCode
  # modular arithmetic class
  module ModularArithmetic
    def cauchy_product(prime, coefficients1, coefficients2)
      product = []
      carry = 0
      (0..coefficients1.size - 1).each do |i|
        sum = 0
        (0..i).each { |j| sum += (coefficients1[j] * coefficients2[i - j]) }
        product << ((carry + sum) % prime)
        carry = (carry + sum) / prime
      end
      product
    end

    def multiplication(prime, coefficients1, coefficients2)
      partial_multiplications = []
      coefficients2.each_with_index do |c1, i|
        rows = multiplication_inner_loop(prime, coefficients1, coefficients2, c1, i)
        partial_multiplications << rows
        rows.append(*([0] * i))
      end
      sum_of_partial_multiplications(partial_multiplications)
    end

    private

    def multiplication_inner_loop(prime, coefficients1, coefficients2, c1_, index)
      rows = []
      carry = 0
      coefficients1.each_with_index do |c2, j|
        rows << ((carry + (c1_ * c2)) % prime)
        carry = (carry + (c1_ * c2)) / prime
        (rows << carry).reverse!.insert(0, *([0] * (j - index))) if j == coefficients2.size - 1
      end
      rows
    end

    def sum_of_partial_multiplications(partial_multiplications)
      carry = 0
      sum = []
      partial_multiplications.map(&:reverse).transpose.map do |x|
        sum << ((carry + x.reduce(:+)) % prime)
        carry = (carry + x.reduce(:+)) / prime
      end
      sum
    end

    def addition(prime, coefficients1, coefficients2)
      carry = 0
      result_coefficients = []
      coefficients1.zip(coefficients2).each do |x|
        result_coefficients << ((carry + x.reduce(:+)) % prime)
        carry = (carry + x.reduce(:+)) / prime
      end
      result_coefficients
    end

    def subtraction(prime,  coefficients1, coefficients2)
      addition(prime, coefficients1, negation(prime, coefficients2))
    end

    def negation(prime, coefficients)
      leading_zeros = coefficients.take_while(&:zero?)
      coefficients_without_leading_zeros = coefficients.drop_while(&:zero?)
      new_coefficients = [(prime - coefficients_without_leading_zeros[0]) % prime]
      new_coefficients += coefficients[leading_zeros.size + 1..].map do |c|
        ((prime - 1) - c) % prime
      end
      leading_zeros + new_coefficients
    end
  end
end
