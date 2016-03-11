#!/usr/bin/env bash

if [[ $OSTYPE == darwin* ]]; then
    bash osx-update.sh
elif [[ $OSTYPE == linux-gnu* ]]; then
    bash linux-update.sh
else
    echo "OS unknown, update manually."
fi
