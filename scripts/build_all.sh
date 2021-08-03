#!/bin/bash

export CXXFLAGS=" -std=c++11 -fPIC"

cd zlib && bash build.sh && cd ..
cd icu && bash build.sh && cd ..
cd tinyxml && bash build.sh && cd ..
cd libusb && bash build.sh && cd ..
cd json-nlohmann && bash build.sh && cd ..
cd sqlite3 && bash build.sh && cd ..
cd eigen3 && bash build.sh && cd ..
cd openssl && bash build.sh && cd ..
cd boost && bash build.sh && cd ..
