#!/bin/sh
if [ ! -f catch/catch.hpp ]; then
  echo "getting catch"
  wget https://raw.githubusercontent.com/philsquared/Catch/master/single_include/catch.hpp -O catch/catch.hpp
else
  echo "catch.hpp is already here"  
fi
