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

  # Musl cross-compilation toolchains via zig cc (for Alpine/musl builds; only installed when needed)
  if [ "${INSTALL_MUSL_TOOLCHAIN:-0}" = "1" ]; then
    # Download zig, which provides built-in musl cross-compilation for all target architectures
    ZIG_VERSION="0.13.0"
    archive="$(mktemp)" || exit 1
    curl -fL "https://ziglang.org/download/${ZIG_VERSION}/zig-linux-x86_64-${ZIG_VERSION}.tar.xz" -o "$archive"
    sudo mkdir -p /opt/zig
    sudo tar xJf "$archive" --strip-components=1 -C /opt/zig
    rm -f "$archive"

    # Create zig cc-backed C/C++ compiler wrappers for each musl target
    for triple in x86_64-linux-musl aarch64-linux-musl i686-linux-musl; do
      case "$triple" in
        x86_64-linux-musl) zig_target="x86_64-linux-musl" ;;
        aarch64-linux-musl) zig_target="aarch64-linux-musl" ;;
        i686-linux-musl) zig_target="x86-linux-musl" ;;
      esac
      # zig cc (clang-based) is stricter than GCC during preprocessing: it rejects
      # gperf template files containing %-directives (e.g. fontconfig's fcobjshash.gperf.h)
      # that GCC silently passes through in -E mode.  Fall back to host GCC/G++ for
      # preprocessing-only invocations so those build steps succeed.
      printf '#!/bin/sh\nfor _a in "$@"; do [ "$_a" = "-E" ] && exec gcc "$@"; done\nexec /opt/zig/zig cc -target %s "$@"\n' "$zig_target" | sudo tee "/usr/local/bin/${triple}-gcc" > /dev/null
      printf '#!/bin/sh\nfor _a in "$@"; do [ "$_a" = "-E" ] && exec g++ "$@"; done\nexec /opt/zig/zig c++ -target %s "$@"\n' "$zig_target" | sudo tee "/usr/local/bin/${triple}-g++" > /dev/null
      printf '#!/bin/sh\nexec /opt/zig/zig ar "$@"\n' | sudo tee "/usr/local/bin/${triple}-ar" > /dev/null
      printf '#!/bin/sh\nexec /opt/zig/zig ar -s "$@"\n' | sudo tee "/usr/local/bin/${triple}-ranlib" > /dev/null
      sudo chmod +x "/usr/local/bin/${triple}-gcc" "/usr/local/bin/${triple}-g++" \
        "/usr/local/bin/${triple}-ar" "/usr/local/bin/${triple}-ranlib"
    done
  fi

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
