# syntax=docker/dockerfile:1.6

ARG version=2023
ARG arch=x86_64-linux
ARG option=full

ARG USERNAME=user
ARG GROUPNAME=user
ARG UID=1000
ARG GID=1000

# Build TeXLive
FROM debian:buster AS builder

ARG version
ARG option

# Move to /tmp
WORKDIR /tmp

# Add profile
COPY profiles/${version}/${option}/texlive.profile /tmp/

# Add install script
COPY install.sh /tmp/

# Install dependencies
RUN <<EOF
   set -eux

   apt-get update
   apt-get install -y curl perl
EOF

# Download TeXLive installer and install them
# This procedure is equivalent to install.sh script.
RUN <<EOF
   set -eux

   # Check final installer existence.
   existfin=0
   curl --retry 3 -s -LI -u anonymous:FTP ftp://tug.org/historic/systems/texlive/${version}/tlnet-final/install-tl-unx.tar.gz || existfin=$?
   
   # Set download url.
   url="ftp://tug.org/historic/systems/texlive/${version}/"
   if [ "$existfin" -eq "0" ]; then
      url=${url}tlnet-final/
   fi
   url=${url}install-tl-unx.tar.gz

   curl --retry 3 --ftp-pasv -u anonymous:FTP ${url} | tar -xz --strip-components=1

   # Set mirror url.
   # We use mirror usualy to use fastest repository, but there is no mirror for older versions.
   # So we use old versions repository reluctantly if we install older version.
   mirrurl="http://mirror.ctan.org/systems/texlive/tlnet/"
   reposurl=$mirrurl
   if [ "$existfin" -eq "0" ]; then
      reposurl="ftp://tug.org/texlive/historic/${version}/tlnet-final/"
   fi

   # You have to prepare profile.
   ./install-tl -profile=texlive.profile -repository $reposurl
EOF


# Working image
FROM debian:buster-slim

LABEL maintainer="kazuaki@ex-t.jp"

ARG version
ARG arch

ARG USERNAME
ARG GROUPNAME
ARG UID
ARG GID

# Add user
RUN <<EOF
   groupadd -g $GID $GROUPNAME
   useradd -m -s /bin/bash -u $UID -g $GID $USERNAME
EOF

# Copy TeXLive from builder
COPY --from=builder /usr/local/texlive /usr/local/texlive

# Install gpg, git, xdg-utils, locales and ghostscript
RUN <<EOF
   set -eux

   apt-get update
   apt-get install -y \
      gpg \
      git \
      xdg-utils \
      locales \
      ghostscript
   rm -rf /var/lib/apt/lists/*

   # generate Japanese locale
   sed -i -E 's/# (ja_JP.UTF-8)/\1/' /etc/locale.gen
   locale-gen
EOF

# Set Lang Japanese
ENV LANG ja_JP.UTF-8

USER ${USERNAME}

# Add TeXLive to PATH
ENV PATH="/usr/local/texlive/${version}/bin/${arch}:${PATH}"

# Set workspace for devcontainer
WORKDIR /workspace

# Run TeXLive
ENTRYPOINT ["tlmgr"]
