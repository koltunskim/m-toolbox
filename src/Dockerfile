from ubuntu:latest

ARG DEBIAN_FRONTEND
LABEL name="m-toolbox"

RUN apt-get update -y
RUN apt-get install -y vim tmux curl dnsutils
RUN apt-get -y install curl ripgrep tree git xclip python3 python3-pip nodejs npm tzdata ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config zip unzip
RUN echo "source /root/.config/.bashrc >> ~/.bashrc"

COPY ./src/scripts/* /tmp/scripts/
RUN /tmp/scripts/bootstrap.sh

#nvim
RUN cd /tmp && git clone https://github.com/neovim/neovim
RUN cd /tmp/neovim && git checkout stable && make -j4 && make install
RUN rm -rf /tmp/neovim


