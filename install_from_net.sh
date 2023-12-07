#!/bin/sh
#
# TeXLive installation script
# Copyright 2023 HyodaKazuaki
#
# Usage: ./install_from_net.sh [YEAR]
# This script downloads TeXLive installer and installs them specified.
#
# YEAR      TeXLive version you want to install. Defaults to this year.
#
# This script is released under MIT License.
# For details, see LICENSE file.

set -eux

YEAR=${1:-`date "+%Y"`}
HISTORIC_MIRROR=ftp://ftp.math.utah.edu/pub/tex/historic/systems/texlive/${YEAR}

echo "##################"
echo "Download installer"
echo "##################"

# Check final installer existence.
existfin=0
curl -s -LI -u anonymous:FTP ${HISTORIC_MIRROR}/tlnet-final/install-tl-unx.tar.gz || existfin=$?

# Set download url.
url="${HISTORIC_MIRROR}/"
if [ "$existfin" -eq "0" ]; then
    url=${url}tlnet-final/
fi
url=${url}install-tl-unx.tar.gz

curl --retry 5 -u anonymous:FTP ${url} | tar -xz --strip-components=1

# Set mirror url.
# We use mirror usualy to use fastest repository, but there is no mirror for older versions.
# So we use old versions repository reluctantly if we install older version.
mirrurl="http://mirror.ctan.org/systems/texlive/tlnet/"
reposurl=$mirrurl
if [ "$existfin" -eq "0" ]; then
    reposurl="${HISTORIC_MIRROR}/tlnet-final/"
fi

echo "#######"
echo "Install"
echo "#######"

# You have to prepare profile.
./install-tl --profile=texlive.profile -repository $reposurl

echo "Installation succeeded"
