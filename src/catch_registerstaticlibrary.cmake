if(NOT DEFINED catch_lib_location)
  message("")
  message("Please define catch_lib_location with the location of the folder containing catch.hpp")
  message("For example:")
  message("set (catch_lib_location ${CMAKE_SOURCE_DIR}/catch)")
  message("")
  message(FATAL_ERROR "Please define catch_lib_location)")
endif()

set(rsl_test_lib_location ${catch_lib_location})
set(rsl_main_test_file ${CMAKE_CURRENT_LIST_DIR}//catch_main.cpp)

include(${CMAKE_CURRENT_LIST_DIR}/rsl_registerstaticlibrary.cmake)
