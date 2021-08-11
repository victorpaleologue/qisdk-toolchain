#!/bin/bash

# Required variables
# BUILD: Name of the library to build

if [ ! -z "$BUILD" ]; then
  cd /opt/scripts
  if [ -f "$BUILD/build.sh" ]; then
    bash "$BUILD/build.sh"
  else
    echo "ERROR Unable to find $BUILD script"
    exit 1
  fi
else
  if [ ! -z "$BUILDALL" ]; then
    cd /opt/scripts
    bash build_all.sh
  else
    bash
  fi
fi
