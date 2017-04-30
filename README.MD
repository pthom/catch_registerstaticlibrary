# Static library testing made easy with catch andcmake

#### Motivation
This is an adaption of [doctest_registerlibrary] (https://github.com/pthom/doctest_registerlibrary) for catch.

The [doctest](https://github.com/onqtam/doctest) documentation says rightfully:
> Tests can be considered a form of documentation and should be able to reside near the production code which they test.*

In the case of a static library, this means that the tests code should reside directly inside the library source files, and *not* inside separate source files.

Unfortunately, the self-registration of the tests does not work as desired when you link a static library : your tests might not be launched at all! This is due to the fact that the linker often strips the self-registration code when it is inside a library.
For a more thorough explanation, see : 
https://github.com/philsquared/Catch/issues/421

https://github.com/onqtam/doctest/issues/21


This project provides a solution, based on the further assumption that :
> Adding tests to a library should be straightforward. Ideally, it should be possible to do it by using a one-line instruction in the library's CMakeList file.

