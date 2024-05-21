#!/bin/bash

## Berbascum's script to upgrade the python prebuilt used by the Droidian buils tools to one with zlib support"

## Install a python prebuilt with zlib module
echo; echo "Checking for python with zlib support..."
read -p "Pauseta..."
INI_DIR=$(pwd)
PYTHON_BASE_VER="2.7"
PYTHON_SUB_VER="2.7.5"
PYTHON_PREFIX="/opt/android/prebuilts/python"
HOST_ARCH="i386"
SUITE="stretch"
export PATH="${PYTHON_PREFIX}/${PYTHON_SUB_VER}/bin:$PATH"
export LD_LIBRARY_PATH="${PYTHON_PREFIX}/${PYTHON_SUB_VER}/lib:${LD_LIBRARY_PATH}"
#export PYTHONPATH="/opt/android/prebuilts/python/${PYTHON_SUB_VER}/lib/python${PYTHON_BASE_VER}"
python2 --version
python2 -c "import zlib"
[ -z "$(python2 -c "import zlib" 2>&1 >/dev/null)" ] && PY_ZLIB_FOUND="True" || PY_ZLIB_FOUND="False"
if [ "${PY_ZLIB_FOUND}" == "False" ]; then
    echo; echo "zlib python support not availabe. Trying to download a prebuit with zlib support..."
    PY_PREBUILT_BASE_URL="https://github.com/berbascum/berb-python-prebuilts/raw/main"
    #PY_PREBUILT_TAR="python${PYTHON_SUB_VER}/python${PYTHON_SUB_VER}-${HOST_ARCH}-${SUITE}-prebuilt_with-zlib-mod.tar.gz"
    PY_PREBUILT_TAR="python${PYTHON_SUB_VER}/python${PYTHON_SUB_VER}-prebuilt-${SUITE}-${HOST_ARCH}-shared_prefix-droidian-android-toolchain.tar.gz"
    wget -O /buildd/sources/python${PYTHON_SUB_VER}-${HOST_ARCH}-prebuilt.tar.gz \
        "${PY_PREBUILT_BASE_URL}/${PY_PREBUILT_TAR}"
    mv "${PYTHON_PREFIX}/${PYTHON_SUB_VER}" "${PYTHON_PREFIX}/${PYTHON_SUB_VER}_orig"
    cd ${PYTHON_PREFIX}
    tar zxvf /buildd/sources/python${PYTHON_SUB_VER}-${HOST_ARCH}-prebuilt.tar.gz
    rm -v /buildd/sources/python${PYTHON_SUB_VER}-${HOST_ARCH}-prebuilt.tar.gz
    cd ${INI_DIR}
else
    echo; echo "zlib python module support detected."
fi
