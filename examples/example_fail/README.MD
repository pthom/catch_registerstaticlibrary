# example_fail
This is an example utf the classic case where static registration fails 
when your tests are placed inside a static library.
See https://github.com/philsquared/Catch/issues/421

If you build this example (using `build.sh`), you will see the following output:

```
➜  example_fail git:(master) ✗ ./build.sh
-- The C compiler identification is AppleClang 8.1.0.8020042
-- The CXX compiler identification is AppleClang 8.1.0.8020042
-- Check for working C compiler: 
...
...
-- Configuring done
-- Generating done
-- Build files have been written to: /dvp/OpenSource/catch_registerstaticlibrary/examples/example_fail/build
Scanning dependencies of target MyLibrary
[ 20%] Building CXX object MyLibrary/CMakeFiles/MyLibrary.dir/lib1.cpp.o
[ 40%] Building CXX object MyLibrary/CMakeFiles/MyLibrary.dir/lib2.cpp.o
[ 60%] Linking CXX static library libMyLibrary.a
[ 60%] Built target MyLibrary
Scanning dependencies of target MyLibraryTest
[ 80%] Building CXX object MyLibrary/CMakeFiles/MyLibraryTest.dir/main_test.cpp.o
[100%] Linking CXX executable ../bin/MyLibraryTest
[100%] Built target MyLibraryTest
===============================================================================
No tests ran    <=== OUCHHHHH
```
