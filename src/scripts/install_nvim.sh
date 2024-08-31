#!/bin/bash

#build from source
cd /tmp && git clone https://github.com/neovim/neovim
cd /tmp/neovim && git checkout stable && make -j4 && make install
rm -rf /tmp/neovim
