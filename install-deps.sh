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
  brew install nasm@2.16 # aom doesn't support newer versions on x64
# Linux
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
