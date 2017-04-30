include("${CMAKE_SOURCE_DIR}/../../src/catch_registerstaticlibrary.cmake")

set(sources lib1.cpp lib2.cpp)
add_library(MyLibrary STATIC lib1.cpp lib2.cpp)
set_property(TARGET MyLibrary PROPERTY CXX_STANDARD 11)
catch_registerstaticlibrary(MyLibrary MyLibraryTest)
