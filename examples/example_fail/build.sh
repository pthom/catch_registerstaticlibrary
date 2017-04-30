#!/usr/bin/env bash

cd ..
./get_catch_hpp_if_needed.sh
cd -

rm -rf build
mkdir build
cd build
cmake ..
make
./bin/MyLibraryTest
