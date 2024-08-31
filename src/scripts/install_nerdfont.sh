#!/bin/bash

curl --location --output /tmp/Inconsolata.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Inconsolata.zip
unzip /tmp/Inconsolata.zip -d /usr/local/share/fonts/
