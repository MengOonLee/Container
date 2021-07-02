FROM ubuntu:focal

LABEL maintainer="Meng Oon Lee <darklemon2000@gmail.com>"

USER root
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y
RUN apt-get install -y \
        texlive-latex-extra \
        texlive-publishers \
        texlive-science \
        locales
RUN apt-get upgrade -y && apt-get autoremove -y
RUN apt-get autoclean && apt-get clean 
RUN rm -rf /var/lib/apt/lists/*
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen

ENV TEX_UID="1000"
USER "${TEX_UID}"

WORKDIR "/app"

CMD ["bash"]
