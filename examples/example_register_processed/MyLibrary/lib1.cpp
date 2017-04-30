#include <iostream>
#include "catch.hpp"

int factorial(int number) { return number <= 1 ? number : factorial(number - 1) * number; }

TEST_CASE("testing the factorial function") {
  std::cout << "testing in lib1.cpp" << std::endl;
  CHECK(factorial(1) == 1);
  CHECK(factorial(2) == 2);
  CHECK(factorial(10) == 3628800);
}

// This code was added by catch_registerstaticlibrary.cmake in order to ensure that the tests are properly run by catch.
// Please commit it if needed, it will be added only once, and never modified.
// Before committing, you can remove this comment, as long as you leave the function below.
int catchRegister_781f5131_2d32_4cd8_92cf_d83b7f4fcd20() { return 0; }
