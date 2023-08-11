#!/bin/sh
#
# TeXLive installation script
# Copyright 2023 HyodaKazuaki
#
# Usage: ./install.sh [YEAR]
# This script downloads TeXLive installer and installs them specified.
#
# YEAR      TeXLive version you want to install. Defaults to this year.
#
# This script is released under MIT License.
# For details, see LICENSE file.

set -eu

YEAR=${1:-`date "+%Y"`}


echo "##################"
echo "Download installer"
echo "##################"

# Check final installer existence.
existfin=0
curl -s -LI -u anonymous:FTP ftp://tug.org/historic/systems/texlive/${YEAR}/tlnet-final/install-tl-unx.tar.gz || existfin=$?

# Set download url.
url="ftp://tug.org/historic/systems/texlive/${YEAR}/"
if [ "$existfin" -eq "0" ]; then
    url=${url}tlnet-final/
fi
url=${url}install-tl-unx.tar.gz

curl -u anonymous:FTP ${url} | tar -xz --strip-components=1

# Set mirror url.
# We use mirror usualy to use fastest repository, but there is no mirror for older versions.
# So we use old versions repository reluctantly if we install older version.
mirrurl="http://mirror.ctan.org/systems/texlive/tlnet/"
reposurl=$mirrurl
if [ "$existfin" -eq "0" ]; then
    reposurl="ftp://tug.org/texlive/historic/${YEAR}/tlnet-final/"
fi

echo "#######"
echo "Install"
echo "#######"

# You have to prepare profile.
./install-tl --profile=texlive.profile -repository $reposurl

echo "Installation succeeded"
