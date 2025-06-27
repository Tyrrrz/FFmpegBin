# FFmpegBin

[![Status](https://img.shields.io/badge/status-maintenance-ffd700.svg)](https://github.com/Tyrrrz/.github/blob/master/docs/project-status.md)
[![Made in Ukraine](https://img.shields.io/badge/made_in-ukraine-ffd700.svg?labelColor=0057b7)](https://tyrrrz.me/ukraine)
[![Build](https://img.shields.io/github/actions/workflow/status/Tyrrrz/FFmpegBin/main.yml?branch=master)](https://github.com/Tyrrrz/FFmpegBin/actions)
[![Release](https://img.shields.io/github/release/Tyrrrz/FFmpegBin.svg)](https://github.com/Tyrrrz/FFmpegBin/releases)
[![Downloads](https://img.shields.io/github/downloads/Tyrrrz/FFmpegBin/total.svg)](https://github.com/Tyrrrz/FFmpegBin/releases)
[![Discord](https://img.shields.io/discord/869237470565392384?label=discord)](https://discord.gg/2SUWKFnHSm)
[![Fuck Russia](https://img.shields.io/badge/fuck-russia-e4181c.svg?labelColor=000000)](https://twitter.com/tyrrrz/status/1495972128977571848)

<table>
    <tr>
        <td width="99999" align="center">Development of this project is entirely funded by the community. <b><a href="https://tyrrrz.me/donate">Consider donating to support!</a></b></td>
    </tr>
</table>

**FFmpegBin** is an automation workflow that produces static builds of [FFmpeg](https://ffmpeg.org) for an array of different platforms.
You can find ready to download assets for each target in the [releases](https://github.com/Tyrrrz/FFmpegBin/releases) of this repository.

Currently supported targets:

|                            | Windows | Linux | macOS | Android            |
| -------------------------- | ------- | ----- | ----- | ------------------ |
| `arm64` / `aarch64`        | ✅      | ✅    | ✅    | ✅ (`arm64-v8a`)   |
| `arm`                      | ❌      | ❌    | ❌    | ✅ (`armeabi-v7a`) |
| `x64` / `x86_64` / `amd64` | ✅      | ✅    | ✅    | ✅                 |
| `x86` / `i386`             | ✅      | ✅    | ❌    | ✅                 |

Builds are performed using [vcpkg](https://github.com/microsoft/vcpkg).
For a list of enabled FFmpeg features, see the [manifest file](vcpkg.json).

## Terms of use<sup>[[?]](https://github.com/Tyrrrz/.github/blob/master/docs/why-so-political.md)</sup>

By using this project or its source code, for any purpose and in any shape or form, you grant your **implicit agreement** to all the following statements:

- You **condemn Russia and its military aggression against Ukraine**
- You **recognize that Russia is an occupant that unlawfully invaded a sovereign state**
- You **support Ukraine's territorial integrity, including its claims over temporarily occupied territories of Crimea and Donbas**
- You **reject false narratives perpetuated by Russian state propaganda**

To learn more about the war and how you can help, [click here](https://tyrrrz.me/ukraine). Glory to Ukraine! 🇺🇦

## Download

- **[Latest version](https://github.com/Tyrrrz/FFmpegBin/releases/latest)**
- [All versions](https://github.com/Tyrrrz/FFmpegBin/releases)

To programmatically fetch a specific release, use the following URL pattern:

```
https://github.com/Tyrrrz/FFmpegBin/releases/download/${VERSION}/ffmpeg-${OS}-${ARCH}.zip
```
