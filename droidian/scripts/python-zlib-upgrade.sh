#!/bin/bash

## Berbascum's script to upgrade the python prebuilt used by the Droidian buils tools to one with zlib support"

## Install a python prebuilt with zlib module

echo; echo "Checking for python with zlib support..."
INI_DIR=$(pwd)
PYTHON_BASE_VER="2.7"
PYTHON_SUB_VER="2.7.5"
PYTHON_PREFIX="/opt/python"
HOST_ARCH="i386"
SUITE="stretch"

export PATH="${PYTHON_PREFIX}/${PYTHON_SUB_VER}/bin:${PATH}"
export LD_LIBRARY_PATH="${PYTHON_PREFIX}/${PYTHON_SUB_VER}/lib:${LD_LIBRARY_PATH}"
#export PYTHONPATH="/opt/android/prebuilts/python/${PYTHON_SUB_VER}/lib/python${PYTHON_BASE_VER}"

#python22 --version
#python22 -c "import zlib"

[ -n "$(which python22)" ] && PY_ZLIB_FOUND="True" || PY_ZLIB_FOUND="False"

if [ "${PY_ZLIB_FOUND}" == "False" ]; then
    echo; echo "\"zlib\" python support not availabe. Trying to download a prebuit with zlib support..."
    ## Create python dest path if not exist
    [ -d "${PYTHON_PREFIX}" ] || mkdir ${PYTHON_PREFIX}

    ## Get the prebuil tar.gz file
    PY_PREBUILT_BASE_URL="https://github.com/berbascum/berb-python-prebuilts/raw/main/python${PYTHON_SUB_VER}"
    PY_PREBUILT_TAR="python${PYTHON_SUB_VER}-${HOST_ARCH}-${SUITE}-prebuilt-zlib_shared_prefix-droidian-android-toolchain.tar.gz"
    #wget -O "/root/${PY_PREBUILT_TAR}" "${PY_PREBUILT_BASE_URL}/${PY_PREBUILT_TAR}"
    wget "${PY_PREBUILT_BASE_URL}/${PY_PREBUILT_TAR}"

    ## Extract the downloaded python prebuilt
    cd ${PYTHON_PREFIX}
    #mv "${PYTHON_SUB_VER}" "${PYTHON_SUB_VER}_orig"
    tar zxvf "${INI_DIR}/${PY_PREBUILT_TAR}"
    cd ${PYTHON_SUB_VER}/bin
    mv ./python ./python22
    cd ${INI_DIR}
    rm -v "${PY_PREBUILT_TAR}"

else
    echo; echo "zlib python module support detected."
fi

python22 --version
echo; echo "Final check for zlib:"
[ -z "$(python22 -c "import zlib" 2>&1 >/dev/null)" ] && PY_ZLIB_FOUND="True" || PY_ZLIB_FOUND="False"

[ "${PY_ZLIB_FOUND}" == "False" ] && echo "zlib support installation failed" && exit
[ "${PY_ZLIB_FOUND}" == "True" ] && echo "zlib support is installed" && exit
