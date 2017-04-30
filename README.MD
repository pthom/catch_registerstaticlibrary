# Static library testing made easy with catch and cmake

#### Motivation
This is an adaption of [doctest_registerlibrary] (https://github.com/pthom/doctest_registerlibrary) for catch.

The [doctest](https://github.com/onqtam/doctest) documentation says rightfully:
> Tests can be considered a form of documentation and should be able to reside near the production code which they test.*

In the case of a static library, this means that the tests code should reside directly inside the library source files, and *not* inside separate source files.

Unfortunately, the self-registration of the tests does not work as desired when you link a static library : your tests might not be launched at all! This is due to the fact that the linker often strips the self-registration code when it is inside a library.
For a more thorough explanation, see : 
* https://github.com/philsquared/Catch/issues/421
* see also https://github.com/onqtam/doctest/issues/21 for the case of doctest


This project provides a solution, based on the further assumption that :
> Adding tests to a library should be straightforward. Ideally, it should be possible to do it by using a one-line instruction in the library's CMakeList file.


## Quick usage instructions

`src/catch_registerstaticlibrary.cmake` provides several cmake functions that make it possible to add tests to a library, using a one-liner instruction in your `CMakeList.txt` file.

For example :
```
include("${CMAKE_SOURCE_DIR}/catch_registerstaticlibrary/src/catch_registerstaticlibrary.cmake")
add_library(MyLibrary STATIC lib1.cpp lib2.cpp)
# The line below will activate the tests for the library !
catch_registerstaticlibrary(MyLibrary MyLibraryTest)  
```

This one-liner will :
- ensure that all tests are actually run. It will add minimal modifications to your code in order to ensure this. More details about this in the [examples](examples/)
- append the doctest include path to your library
- create an executable test target (MyLibraryTest) for your library
- register it as a cmake test (so that `ctest` or `make test`) will launch it.



## Detailed usage instructions :

#### Step 1 : include catch and catch_registerstaticlibrary in your project

For example :
* copy [catch.hpp](https://raw.githubusercontent.com/philsquared/Catch/master/single_include/catch.hpp) into your project/catch folder
* copy [catch_registerstaticlibrary](https://github.com/pthom/catch_registerstaticlibrary) at the root of your project, such as shown below:
```
YourProject/
├── CMakeLists.txt
├── YourLibrary/
│   ├── CMakeLists.txt
│   ├── lib1.cpp
│   └── lib2.cpp
├── catch
│   ├── catch.hpp
└── catch_registerstaticlibrary/
    └── src/
        ├── catch_main.cpp
        ├── catch_registerstaticlibrary.cmake
        └── catch_registerstaticlibrary.py
```

#### Step 2 : Adjust the paths in `catch_registerstaticlibrary.cmake`

If needed, adjust the paths in the first two lines of `catch_registerstaticlibrary.cmake`

```
set (catch_lib_location ${CMAKE_SOURCE_DIR}/catch)
set (catch_registerstaticlibrary_location ${CMAKE_SOURCE_DIR}/catch_registerstaticlibrary)
```


#### Step 3 : enable tests for your project
Enable tests in cmake, by adding the following line to your project's main `CMakeLists.txt` file:

```
enable_testing()
```

#### Step 4 : Register tests for your library

in the `CMakeLists.txt` of your library
* Include "catch_registerstaticlibrary.cmake"
* Call `catch_registerstaticlibrary(YourLibrary YourLibraryTest)` (where YourLibrary is the name of your library and YourLibraryTest is the name of the test executable that will be created)

Example :
```
include("${CMAKE_SOURCE_DIR}/catch_registerstaticlibrary/src/catch_registerstaticlibrary.cmake")
add_library(MyLibrary STATIC lib1.cpp lib2.cpp)
catch_registerstaticlibrary(YourLibrary YourLibraryTest)
```

##  'A la carte' instructions

`catch_registerstaticlibrary(YourLibrary YourLibraryTest)` does different actions that can be called separately. See below  for the detail of those actions.

### auto-generated code

##### catch_registercppfiles
`catch_registercppfiles(YourLibrary)` will make some small changes to your cpp files in order to ensure that tests are actually run : it will modify your cpp files by adding a dummy function `catchRegister_[GUID]()`.
  This modification is done only once, and can be committed. Your cpp files will not be modified unless they actually use catch (i.e they include `catch.hpp` or they include a `TEST_CASE`)


##### catch_create_registermainfile
`catch_create_registermainfile(YourLibrary)` will create a file `catch_registerstaticlibrary.cpp` that will call these dummy functions : this is the secret in order to make the self-registration of tests work with a static library.
This file can also be committed and will only be modified when new source files are added to the library.

##### More details

See [the examples](examples/) for more details.

### Utilities

##### catch_appendregisterlibrarycpp_tosources
`catch_appendregisterlibrarycpp_tosources(YourLibrary)` can be used in conjunction with `catch_registercppfiles()`. It will add the `catch_registerstaticlibrary.cpp` file to your library sources files.

##### catch_addincludepath
`catch_addincludepath(YourLibrary)` will simply add the catch include path to your library.

##### catch_maketesttarget
`catch_maketesttarget(YourLibrary YourLibraryTest)` will create an executable target for your tests

##### catch_register_ctest
`catch_register_ctest(YourLibraryTest)` will register this exe as a test (so that `make test` or `ctest` will launch it)
