# example_fail
This is an example of the classic case where static registration fails when your tests are placed inside a static library.
See https://github.com/philsquared/Catch/issues/421

If you build this example (using `build.sh` or `build.bat`), you will see the following output:

```
➜  example_fail git:(master) ✗ ./build.sh
          ...   (lots of lines) ...
-- Build files have been written to: /dvp/OpenSource/catch_registerstaticlibrary/examples/example_fail/build
          ...   (lots of lines) ...
[100%] Built target MyLibraryTest
No tests ran    <=== OUCHHHHH
```
