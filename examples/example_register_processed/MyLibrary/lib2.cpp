#define DEBUG
#include <iostream>
#include "catch.hpp"

TEST_CASE("testing in lib2.cpp") {
    std::cout << "testing in lib2.cpp" << std::endl;
    CHECK((1+1) == 2);
}

// This code was added by rsl_registerstaticlibrary.cmake in order to ensure that the tests are properly run.
// Please commit it if needed, it will be added only once, and never modified.
// Before committing, you can remove this comment, as long as you leave the function below.
int RslRegister_585e2fbf_a17b_46a2_887a_093a38c17173() { return 0; }
