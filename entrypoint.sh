#!/bin/sh
echo "Debug: Number of arguments passed: $#"
echo "Debug: Arguments received: $@"
if [ $# -eq 0 ]; then
    echo "Executing go version because no arguments were passed."
    exec go version
else
    echo "Executing passed command: $@"
    exec "$@"
fi

