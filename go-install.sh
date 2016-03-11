#!/usr/bin/env sh

go get -u github.com/alecthomas/gometalinter && \
    gometalinter --install --update

go get -u github.com/pilu/fresh

go get -u github.com/nsf/gocode
