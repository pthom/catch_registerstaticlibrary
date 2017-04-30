#define CATCH_CONFIG_RUNNER
#include "catch.hpp"

int CatchRegisterStaticLibrary();

// Inspired from 
// https://github.com/philsquared/Catch/blob/master/docs/own-main.md
int main( int argc, char* argv[] )
{
  int result = Catch::Session().run( argc, argv );
  result = result < 0xff ? result : 0xff );
  
  int dummy = CatchRegisterStaticLibrary(); // is always 0
  return result + dummy;
}
