### example_fail
This is an example of the classic case where static registration fails when your tests are placed inside a static library.
See https://github.com/philsquared/Catch/issues/421

If you run the tests, you will see the following output (OUCH...)
```
==============================================================================
No tests ran
```

### example_register
`example_register/` is an example of a complete project with a library that will be tested.

Build it by calling `build.sh`
This will create a folder named `build`. You can run the test with either `ctest` or `make test` inside this folder.


### example_register_processed
`example_register_processed/` is a copy of `example_register/`, in which the cpp source code was modified after cmake was executed.

You can see the auto-generated functions `catchRegister_[GUID]()` as well as the auto-generated `catch_registerstaticlibrary.cpp` file.

Build it by calling `build.sh`


### detailed differences

```
▶ diff -Naur example_register/MyLibrary/catch_registerstaticlibrary.cpp example_register_processed/MyLibrary/catch_registerstaticlibrary.cpp
--- example_register/MyLibrary/catch_registerstaticlibrary.cpp	1970-01-01 01:00:00.000000000 +0100
+++ example_register_processed/MyLibrary/catch_registerstaticlibrary.cpp	2017-04-30 16:01:44.000000000 +0200
@@ -0,0 +1,17 @@
+
+// This file is autogenerated.
+// It was added by catch_registerstaticlibrary.cmake in order to ensure that the tests are properly run by catch.
+// Please commit it if needed, it will be modified only if new files are added.
+
+int catchRegister_781f5131_2d32_4cd8_92cf_d83b7f4fcd20();
+int catchRegister_d040fbb6_21b9_4865_8de0_c05702d9ae1e();
+
+
+int CatchRegisterStaticLibrary()
+{
+  int dummy_sum = 0;
+  dummy_sum += catchRegister_781f5131_2d32_4cd8_92cf_d83b7f4fcd20();
+  dummy_sum += catchRegister_d040fbb6_21b9_4865_8de0_c05702d9ae1e();
+
+  return dummy_sum;
+}
diff -Naur example_register/MyLibrary/lib1.cpp example_register_processed/MyLibrary/lib1.cpp
--- example_register/MyLibrary/lib1.cpp	2017-04-30 15:59:41.000000000 +0200
+++ example_register_processed/MyLibrary/lib1.cpp	2017-04-30 16:01:44.000000000 +0200
@@ -9,3 +9,8 @@
   CHECK(factorial(2) == 2);
   CHECK(factorial(10) == 3628800);
 }
+
+// This code was added by catch_registerstaticlibrary.cmake in order to ensure that the tests are properly run by catch.
+// Please commit it if needed, it will be added only once, and never modified.
+// Before committing, you can remove this comment, as long as you leave the function below.
+int catchRegister_781f5131_2d32_4cd8_92cf_d83b7f4fcd20() { return 0; }
diff -Naur example_register/MyLibrary/lib2.cpp example_register_processed/MyLibrary/lib2.cpp
--- example_register/MyLibrary/lib2.cpp	2017-04-30 15:59:41.000000000 +0200
+++ example_register_processed/MyLibrary/lib2.cpp	2017-04-30 16:01:44.000000000 +0200
@@ -6,3 +6,8 @@
     std::cout << "testing in lib2.cpp" << std::endl;
     CHECK((1+1) == 2);
 }
+
+// This code was added by catch_registerstaticlibrary.cmake in order to ensure that the tests are properly run by catch.
+// Please commit it if needed, it will be added only once, and never modified.
+// Before committing, you can remove this comment, as long as you leave the function below.
+int catchRegister_d040fbb6_21b9_4865_8de0_c05702d9ae1e() { return 0; }
```