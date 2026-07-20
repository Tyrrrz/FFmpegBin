#!/bin/sh -e

# macOS
if [ "$(uname)" == "Darwin" ]; then
  brew update

  brew install autoconf
  brew install autoconf-archive
  brew install automake
  brew install libtool
  brew install libx11
  brew install libxft
  brew install libxext
  brew install nasm
# Alpine (musl container)
elif [ -f /etc/alpine-release ]; then
  # Enable community repo for extras, pinned to the same Alpine branch as the container
  ALPINE_VERSION=$(cut -d. -f1,2 /etc/alpine-release)
  echo "https://dl-cdn.alpinelinux.org/alpine/v${ALPINE_VERSION}/community" >> /etc/apk/repositories
  apk update

  # Core build toolchain (gcc/g++ here target musl natively)
  apk add --no-cache \
    bash git curl zip tar \
    cmake ninja build-base linux-headers \
    autoconf autoconf-archive automake libtool libtool-dev \
    nasm pkgconf \
    libx11-dev libxft-dev libxext-dev \
    wayland-dev libxkbcommon-dev \
    mesa-egl-dev \
    python3

  # aarch64 cross-compilation toolchain (musl.cc - musl-targeting, not bare-metal)
  MUSL_VERSION="12.4.0-musl-1.2.5"
  MUSL_BASE_URL="https://musl.cc/files/binaries/${MUSL_VERSION}"
  curl -fsSL "${MUSL_BASE_URL}/aarch64-linux-musl-cross.tgz" | tar -xz -C /opt

  if [ -n "${GITHUB_PATH:-}" ]; then
    echo "/opt/aarch64-linux-musl-cross/bin" >> "$GITHUB_PATH"
  else
    export PATH="$PATH:/opt/aarch64-linux-musl-cross/bin"
  fi
# Linux (glibc)
else
  # Allow :i386 architecture for 32-bit cross-compilation support
  sudo dpkg --add-architecture i386

  # Update package lists
  sudo apt update

  # Cross-compilation support
  sudo apt install linux-headers-$(uname -r)
  sudo apt install linux-libc-dev:i386
  sudo apt install libc6-dev-i386
  sudo apt install gcc-multilib
  sudo apt install gcc-aarch64-linux-gnu
  sudo apt install g++-multilib
  sudo apt install g++-aarch64-linux-gnu

  # FFmpeg dependencies
  sudo apt install autoconf
  sudo apt install autoconf-archive
  sudo apt install automake
  sudo apt install libtool
  sudo apt install libltdl-dev
  sudo apt install libx11-dev
  sudo apt install libxft-dev
  sudo apt install libxext-dev
  sudo apt install libwayland-dev
  sudo apt install libxkbcommon-dev
  sudo apt install libegl1-mesa-dev
  sudo apt install libibus-1.0-dev
  sudo apt install nasm
  sudo apt install pkg-config
fi
