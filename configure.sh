#! /bin/sh

#cmake -S . -B out/build
cmake -B out/build -S . -DCMAKE_CXX_COMPILER=icpx
