cmake_minimum_required(VERSION 3.0)

execute_process(COMMAND ${CMAKE_SOURCE_DIR}/../../get_catch_hpp_if_needed.sh WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/../..)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
enable_testing()
add_subdirectory(MyLibrary)
