#!/usr/bin/env sh

go get -u github.com/alecthomas/gometalinter && \
    gometalinter --install --update

go get -u github.com/pilu/fresh

go get -u github.com/nsf/gocode

go get -u github.com/motemen/gore

go get -u github.com/tools/godep

go get -u -v github.com/rogpeppe/godef
go get -u -v golang.org/x/tools/cmd/oracle
go get -u -v golang.org/x/tools/cmd/gorename
