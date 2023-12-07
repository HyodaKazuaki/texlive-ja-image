#!/bin/bash
#
# TeXLive custom binary download script
# Copyright 2023 HyodaKazuaki
#
# Usage: ./download_custom_binary.sh [YEAR]
# This script downloads TeXLive custom binary for arm64 architecture support.
#
# YEAR      TeXLive version you want to install. Defaults to this year.
#
# This script is released under the MIT License.
# For details, see LICENSE file.

set -eux

YEAR=${1:-`date "+%Y"`}
YEAR=$(($YEAR + 0)) # Convert to integer.

# Check the year supported.
if [ $YEAR -lt 2019 ]; then
    echo "TeXLive version $YEAR is not supported since there is no custom binary for this version."
    exit 1
fi

declare -A urls=(
    ["2019"]="https://ftp.math.utah.edu/pub/texlive-utah-2019/bin/aarch64-linux.tar.xz"
    ["2020"]="https://ftp.math.utah.edu/pub/texlive-utah-2020/bin/aarch64-linux.tar.xz"
    ["2021"]="https://ftp.math.utah.edu/pub/texlive-utah-2021/bin/aarch64-linux.tar.xz"
    ["2022"]="https://ftp.math.utah.edu/pub/texlive-utah-2022/bin/arm64-debian11.tar.xz"
    ["2023"]="https://ftp.math.utah.edu/pub/texlive-utah-2023/bin/aarch64-linux.tar.xz"
)

echo "######################"
echo "Download custom binary"
echo "######################"

mkdir -p custom_bin

cd custom_bin

curl ${urls[$YEAR]} | tar -xJ --strip-components=1

echo "Download succeeded to `pwd`"
