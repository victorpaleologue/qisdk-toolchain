# qisdk-toolchain

Toolchain build scripts for linux OS
====================================

Build and run the environment
-----------------------------

```
# Build the image (or use the official one):
docker build --rm -t release-toolchain -f Dockerfile .

# Run the image (it will add or update all jobs describe in this project)
docker run -ti --rm --name release-toolchain release-toolchain
```

Available scripts:
------------------

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

Notes:
------

# to check ABI version
readelf -h lib.so
