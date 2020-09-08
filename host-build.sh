#!/bin/bash
# https://stackoverflow.com/questions/36173840/how-to-instruct-cmake-to-use-the-build-architecture-compiler

# Make sure we have a 'build' folder.
if [ ! -d "hostbuild" ]; then
    mkdir hostbuild
fi

cmake -S hosttools -B hostbuild -DCMAKE_INSTALL_PREFIX=./hostbuild/install
# Hop into the 'build' folder to start our CMake build.
pushd hostbuild
    make
popd