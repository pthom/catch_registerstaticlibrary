include("${CMAKE_SOURCE_DIR}/catch_registerstaticlibrary/src/catch_registerstaticlibrary.cmake")

#include_directories("../../../catch/")
set(sources lib1.cpp lib2.cpp)

add_library(MyLibrary STATIC lib1.cpp lib2.cpp)
set_property(TARGET MyLibrary PROPERTY CXX_STANDARD 11)

  set(libraryName MyLibrary)

  catch_addincludepath(${libraryName})
  # catch_registercppfiles(${libraryName})
  # catch_create_registermainfile(${libraryName})
  # catch_appendregisterlibrarycpp_tosources(${libraryName})

  # catch_maketesttarget(${libraryName} ${testTargetName})
  # catch_register_ctest(${testTargetName})
