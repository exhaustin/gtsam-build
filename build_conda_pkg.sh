#!/usr/bin/env bash

BASEDIR=$(dirname $0)
PYTHON_VERSIONS=('3.6' '3.7' '3.8' '3.9')
#PYTHON_VERSIONS=("3.8")

# Login to anaconda cloud
echo -n "Anaconda cloud username: "
read ANACONDA_USER
echo -n "Anaconda cloud password: "
read -s ANACONDA_PASSWORD
echo ""

anaconda login --username $ANACONDA_USER --password $ANACONDA_PASSWORD
unset ANACONDA_PASSWORD

conda config --set anaconda_upload no

# Build for each python version
for py_ver in "${PYTHON_VERSIONS[@]}"; do
    # Rebuild package
    export PYTHON_VERSION=${py_ver}
    conda build --py ${py_ver} -c conda-forge -c anaconda $BASEDIR/conda_recipe

    # Upload to anaconda cloud
    anaconda upload --user fair-robotics --skip ~/miniconda3/conda-bld/linux-64/gtsam*.tar.bz*
done
