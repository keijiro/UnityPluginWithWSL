UnityPluginWithWSL
==================

![screenshot](https://i.imgur.com/JbbioDQl.png)

This is an example that shows how to build a Unity native plugin using the WSL
(Windows Subsystem for Linux) development environment.

How to build the plugin
-----------------------

- Enable WSL and install Ubuntu.
- Install `make`.
  - `sudo apt install make`
- Install `mingw-w64` (development toolchain targeting 64-bit Windows).
  - `sudo apt install mingw-w64`
- Run `make` in the `Plugin` directory with `Makefile.windows`.
  - `cd Plugin && make -f Makefile.windows`
