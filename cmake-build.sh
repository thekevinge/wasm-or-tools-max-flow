#!/bin/bash
# Adapted from
# http://marcelbraghetto.github.io/a-simple-triangle/2019/03/10/part-06/

# Include host-build.sh to make sure binary hostversion of protobuf::protoc is available for emscripten build
source host-build.sh

# Make sure we have a 'wasmbuild' folder.
if [ ! -d "wasmbuild" ]; then
    mkdir wasmbuild
fi

# In order to find the Emscripten build tools, we need to configure some environment variables so they are available during the build. The required environment variables are initialized by sourcing the 'emsdk_env.sh' that ships with the Emscripten SDK.
pushd emscripten
    echo "Configuring Emscripten environment variables"
    . ./emsdk_env.sh
popd

# Hop into the 'build' folder to start our CMake build.
pushd wasmbuild

    EMSCRIPTEN=${EMSDK}/upstream/emscripten
	
    # Because we sourced the Emscripten environment variables, we can use the 'EMSCRIPTEN' var to know where the current SDK can be found, which we need so we can locate the 'Emscripten.cmake' toolchain file.
    EMSCRIPTEN_CMAKE_PATH=${EMSCRIPTEN}/cmake/Modules/Platform/Emscripten.cmake

    # We ask CMake to configure itself against the parent folder, but unlike our other platform targets, we will tell CMake to use the Emscripten CMake toolchain which knows how to perform Emscripten builds.
    echo "Emscripten CMake path: ${EMSCRIPTEN_CMAKE_PATH}"
    cmake -DCMAKE_TOOLCHAIN_FILE=${EMSCRIPTEN_CMAKE_PATH} .. -DBUILD_DEPS=ON -DBUILD_SAMPLES=OFF -DBUILD_EXAMPLES=OFF -DBUILD_TESTING=OFF -DCMAKE_INSTALL_PREFIX=./install
    # cmake -DCMAKE_TOOLCHAIN_FILE=${EMSCRIPTEN_CMAKE_PATH} .. -DBUILD_DEPS=OFF -DBUILD_ZLIB=ON -DBUILD_glog=ON -DBUILD_SAMPLES=OFF -DBUILD_EXAMPLES=OFF -DBUILD_TESTING=OFF

    # Start the actual build.
    echo "Building project ..."
    make install
popd