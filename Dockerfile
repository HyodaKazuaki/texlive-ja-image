# syntax=docker/dockerfile:1.6

ARG builder_name=from_iso
ARG iso_dir=texlive
ARG version=2023
ARG arch=x86_64-linux
ARG option=full

ARG USERNAME=user
ARG GROUPNAME=user
ARG UID=1000
ARG GID=1000


# Build TeXLive from iso
FROM debian:buster AS from_iso

ARG iso_dir
ARG version
ARG option

# Move to /tmp
WORKDIR /tmp

# Add ISO data
COPY ${iso_dir} /tmp

# Add profile
COPY profiles/${version}/${option}/texlive.profile /tmp/

# Install dependency
RUN <<EOF
   set -eux

   apt-get update
   apt-get install -y perl
EOF

# Install TeXLive
RUN ./install-tl -profile=texlive.profile


# Build TeXLive from net
FROM debian:buster AS from_net

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
RUN sh ./install_from_net.sh ${version}


# Intermediate builder for multistage selection
FROM ${builder_name} as intermediate_builder


# Working image
FROM debian:buster-slim

LABEL maintainer="kazuaki@ex-t.jp"

ARG builder_name
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
COPY --from=intermediate_builder /usr/local/texlive /usr/local/texlive

# Install gnupg2, git, xdg-utils, locales and ghostscript
RUN <<EOF
   set -eux

   apt-get update
   apt-get install -y \
      gnupg2 \
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
