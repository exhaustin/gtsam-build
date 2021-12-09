#!/usr/bin/env bash

if [ -z "$PREFIX" ]; then PREFIX=$CONDA_PREFIX; fi
if [ -z "$PYTHON_VERSION" ]; then PYTHON_VERSION=3.8; fi

BUILD_PATH="./build"
mkdir -p $BUILD_PATH && cd $BUILD_PATH

echo "========== BUILDING GTSAM WITH PYTHON VERSION ${PYTHON_VERSION} =========="
cmake -DGTSAM_BUILD_PYTHON=1 -DGTSAM_PYTHON_VERSION=$PYTHON_VERSION \
    -DCMAKE_ARCHIVE_OUTPUT_DIRECTORY=$PREFIX/lib \
    -DCMAKE_LIBRARY_OUTPUT_DIRECTORY=$PREFIX/lib \
    -DCMAKE_RUNTIME_OUTPUT_DIRECTORY=$PREFIX/bin ..
make
make python-install
echo "========== BUILD COMPLETE =========="

cd -
