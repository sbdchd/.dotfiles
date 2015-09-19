#! /bin/sh

install=all
if [ "$1" == "-small" ]; then
    install=small 
fi

echo $install
