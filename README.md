# Qi SDK Toolchain

This repository contains scripts to build
a [`qibuild`](https://github.com/aldebaran/qibuild) toolchain
that allows to build the [!libQi project](https://github.com/aldebaran/libqi)
and its related components that compose the Qi SDK.

This project is for Linux x86_64 only,
and does not produce a toolchain for NAO or Pepper.

## Usage

To use this toolchain with in a [`qibuild`](https://github.com/aldebaran/qibuild) project:

```
qitoolchain create <your_toolchain_name> <path_to_feed_xml_in_release>
qibuild add-config <your_config_name> -t <your_toolchain_name>
qibuild configure -c <your_config_name>
qibuild make -c <your_config_name>
```

## Build and run with Docker

Build the image (or use the official one):
```
docker build --rm -t release-toolchain -f Dockerfile .
```

Run the image (it will add or update all jobs described in this project)
```
docker run -ti --rm --name release-toolchain release-toolchain
```

Running the build scripts results in a set of `.zip` files
in the `$WORKSPACE` folder (defaulted to `/tmp/workspace`).

The toolchain feed is produced using [`make_feed.sh`](make_feed.sh),
which relies on the latest release found on the GitHub repository.
(TODO: make it work on the build results instead)

## Available scripts:

* icu             -> Done  
* zlib            -> Done  
* openssl         -> Done  
* boost           -> Done  
* libusb          -> Done  
* tinyxml         -> Done  
* json-nlohmann   -> Done  
* sqlite          -> Done  
* eigen3          -> Done  
* freeimage       -> Todo  
* pthread         -> Todo  
* opencv          -> Todo  

1) zlib, icu, tinyxml, json-nlohmann (header only), pthread (windows only)  
2) libusb, boost (depends: zlib, icu), openssl (depends: zlib)  
3) eigen3 (header only), sqlite, freeimage (optionnal?)  
4) opencv (depends: eigen, freeimage, sqlite?)

## Notes

### To check ABI version

```
readelf -h lib.so
```

### Boost

The `boost-config.cmake` included in the toolchain differs much from
the one that `qitoolchain` would generate when calling `qitoolchain make-package`,
and also from the one provided by the CMake project (as `FindBoost.cmake`).
It is inherited by the legacy toolchains provided for NAOqi versions 2.5 and lower.
