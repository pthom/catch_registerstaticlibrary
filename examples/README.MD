### example_fail
This is an example of the classic case where static registration fails when your tests are placed inside a static library.
See https://github.com/philsquared/Catch/issues/421

Build it and run the tests using `build.sh`

If you run the tests, you will see the following output :
```
No tests ran
```

Ouch...

### example_register
`example_register/` is an example of a complete project with a library that will be tested.

Build it by calling `build.sh`
This will create a folder named `build`. 
You can run the tests from the build folder with either one of the commands below: 
1. `ctest` 
2. `make test` inside this f`lder
3. `./bin/MyLibraryTest`


### example_register_processed
`example_register_processed/` is a copy of `example_register/`, in which the cpp source code was modified after cmake was executed.

You can see the auto-generated functions `catchRegister_[GUID]()` as well as the auto-generated `catch_registerstaticlibrary.cpp` file.


### detailed differences

See the commit https://github.com/pthom/catch_registerstaticlibrary/commit/974cb65ba8a3c81d48089e9cf27276dc6f4ae41a
which shows the complete diff upon the first build (the modification are applied only once).

