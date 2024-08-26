#!/bin/bash

#install dependencies
apt-get update -y
apt-get -y install curl ripgrep tree git xclip python3 python3-pip nodejs npm tzdata ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config zip unzip

#build from source
cd /tmp && git clone https://github.com/neovim/neovim
cd /tmp/neovim && git checkout stable && make -j4 && make install
rm -rf /tmp/neovim
