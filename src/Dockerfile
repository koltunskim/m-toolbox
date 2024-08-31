from ubuntu:latest

ARG DEBIAN_FRONTEND
LABEL name="m-toolbox"

RUN echo "source /root/.config/.bashrc >> ~/.bashrc"

COPY ./src/scripts/* /tmp/scripts/
RUN /tmp/scripts/bootstrap.sh
