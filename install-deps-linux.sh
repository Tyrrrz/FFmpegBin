#!/bin/sh -e

# Allow :i386 architecture for 32-bit cross-compilation support
dpkg --add-architecture i386

# Update package lists
apt update

# Cross-compilation support
apt install linux-headers-$(uname -r)
apt install linux-libc-dev:i386
apt install libc6-dev-i386
apt install gcc-multilib
apt install gcc-aarch64-linux-gnu
apt install g++-multilib
apt install g++-aarch64-linux-gnu

# FFmpeg dependencies
apt install autoconf
apt install automake
apt install libtool
apt install libltdl-dev
apt install libx11-dev
apt install libxft-dev
apt install libxext-dev
apt install libwayland-dev
apt install libxkbcommon-dev
apt install libegl1-mesa-dev
apt install libibus-1.0-dev
apt install nasm
apt install pkg-config