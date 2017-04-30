include_directories("../../../catch/")
set(sources lib1.cpp lib2.cpp)

add_library(MyLibrary STATIC lib1.cpp lib2.cpp)
set_property(TARGET MyLibrary PROPERTY CXX_STANDARD 11)

add_executable(MyLibraryTest main_test.cpp)
target_link_libraries(MyLibraryTest MyLibrary)
add_test(MyLibraryTest ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/MyLibraryTest)