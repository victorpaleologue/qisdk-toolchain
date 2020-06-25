# qisdk-toolchain

Toolchain script and feeds

## To check ABI version
readelf -h lib.so

feeds/
    linux64-buster
    mac64-sierra
    win64-vs2015
scripts/
    icu             -> Done
    zlib            -> Done
    openssl         -> Done
    boost           -> Done
    libusb          -> Done
    tinyxml         -> Done
    json-nlohmann   -> Done
    sqlite          -> Done
    eigen3          -> Done
    freeimage       -> Todo
    pthread         -> Todo
    opencv          -> Todo

1) zlib, icu, tinyxml, json-nlohmann (header only), pthread (windows only)
2) libusb, boost (depends: zlib, icu), openssl (depends: zlib)
3) eigen3 (header only), sqlite, freeimage (optionnal?)
4) opencv (depends: eigen, freeimage, sqlite?)
