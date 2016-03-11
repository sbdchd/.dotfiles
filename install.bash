#!/usr/bin/env bash

if [[ $OSTYPE == darwin* ]]; then
    bash osx-install.sh
elif [[ $OSTYPE == linux-gnu* ]]; then
    bash linux-install.sh
else
    echo "OS unknown, install manually."
fi
