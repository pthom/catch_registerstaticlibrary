set(rsl_main_test_file ${CMAKE_CURRENT_LIST_DIR}//catch_main.cpp)

# words that indicate that a cpp file actually implements tests (using catch for example)
# if any line in the file contains one of these words, it will be considered as a file that implements tests
# (and thus the registration code will be added to it)
set(rsl_testfile_code_hints "[\\\"catch.hpp\\\", \\\"TEST_CASE\\\", \\\"SCENARIO\\\"]")

include(${CMAKE_CURRENT_LIST_DIR}/rsl_registerstaticlibrary.cmake)
