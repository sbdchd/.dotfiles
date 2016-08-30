#!/usr/bin/env bash

# from https://github.com/tomchuk
{ infocmp -1 xterm-256color ; echo -e "\tsitm=\\E[3m,\n\tritm=\\E[23m,"; } > /tmp/xterm-256color.terminfo && \
tic /tmp/xterm-256color.terminfo
