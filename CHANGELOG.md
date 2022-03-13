## [0.3.0] - 2022-03-12

- Add the `Polynomial` class for arithmetic with fixed-length polynomials
- Change the class `TruncatedFinitePadicExpansion` for carrying all computaitons over fixed-length polynomials reduced modulo `p`
- Add the third type of supported Hensel code: the truncated finite-segment g-adic Hensel code.
- Add `GAdicBase` as the parent class of `TruncatedFiniteGadicExpansion`.
- Allow converting a finite-segment p-adic Hensel code into a truncated p-adic Hensel code.
- Add the Chinese Remainder Theorem algorithm (CRT) to the module `Tools`
- Improve helpers for generating distinct random numbers (integers, primes, and rationals)
- Add the inverse function for all three currently supported types of Hensel codes
- Overall improvements in the code

## [0.2.1] - 2022-03-05
- Fix version build

## [0.2.0] - 2022-03-05

- Add the second type of supported Hensel code: the finite-segment p-adic Hensel code.
- Allow converting a finite-segment p-adic Hensel code into a truncated p-adic Hensel code.
- Support all four arithemtic operations.
- Add `PAdicBase` as the parent class of `FinitePadicExpansion` and `TruncatedFinitePadicExpansion`.


## [0.1.0] - 2022-03-03

- Initial release
- Contain general tools for integer manipulation such us random number generation, random integer generation, extended gcd, and modular multiplicative inverse.
- Add the first type of supported Hensel code: the truncated finite-segment p-adic expansion Hensel code or simply truncated p-adic Hensel code.
- Allow encoding rational numbers with the classs `TruncatedFinitePadicExpansion` and perform all four basic arithmetic operations on truncated p-adic Hensel codes: addition, subtraction, multiplication, and division.
