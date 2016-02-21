#!/usr/bin/env sh

go get github.com/alecthomas/gometalinter && \
    gometalinter --install --update

go get github.com/pilu/fresh
