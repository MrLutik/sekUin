#!/bin/sh
if [ $# -eq 0 ]; then
    echo "Executing go version because no arguments were passed."
    exec go version
else
    echo "Executing passed command: $@"
    exec "$@"
fi

