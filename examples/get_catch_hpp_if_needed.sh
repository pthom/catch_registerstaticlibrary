#!/bin/sh
if [ ! -f catch/catch.hpp ]; then
  echo "getting latest catch.hpp version into examples/catch/catch.hpp"
  mkdir catch
  wget https://raw.githubusercontent.com/philsquared/Catch/master/single_include/catch.hpp -O catch/catch.hpp
else
  echo "examples/catch/catch.hpp is already here"
fi
