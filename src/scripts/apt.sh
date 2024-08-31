#!/bin/bash

apt-get -y update

#vim dependencies
apt-get -y install curl ripgrep tree git xclip python3 python3-pip python3-all-venv nodejs npm tzdata ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config zip unzip

#tools
apt-get -y install vim tmux curl dnsutils ripgrep
