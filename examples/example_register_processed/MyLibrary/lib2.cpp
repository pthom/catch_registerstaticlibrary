#define DEBUG
#include <iostream>
#include "catch.hpp"

TEST_CASE("testing in lib2.cpp") {
    std::cout << "testing in lib2.cpp" << std::endl;
    CHECK((1+1) == 2);
}

// This code was added by catch_registerstaticlibrary.cmake in order to ensure that the tests are properly run by catch.
// Please commit it if needed, it will be added only once, and never modified.
// Before committing, you can remove this comment, as long as you leave the function below.
int catchRegister_d040fbb6_21b9_4865_8de0_c05702d9ae1e() { return 0; }
