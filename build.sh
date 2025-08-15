#!/usr/bin/env bash

cmake -B build -C cmake/caches/PredefinedParams.cmake -DCMAKE_BUILD_TYPE=Release -DLLVM_PARALLEL_COMPILE_JOBS=10 -DLLVM_PARALLEL_LINK_JOBS=10 -DHLSL_INCLUDE_TESTS=OFF -DSPIRV_BUILD_TESTS=OFF

cmake --build build --config Release --target dxcompiler -j10
cmake --build build --config Release --target dxc -j10

install_name_tool -delete_rpath @executable_path/../lib build/bin/dxc
install_name_tool -add_rpath    @executable_path build/bin/dxc

cmake --install build --component dxc --prefix .dist
cmake --install build --component dxcompiler --prefix .dist
