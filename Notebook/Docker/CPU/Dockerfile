ARG BASE=tensorflow/tensorflow:latest
FROM $BASE

ARG NB_USER=meng
ARG NB_UID=1000
ARG NB_GID=100

ENV SHELL=/bin/bash
ENV NB_USER=$NB_USER
ENV NB_UID=$NB_UID
ENV NB_GID=$NB_GID
ENV HOME=/home/$NB_USER
ENV VENV=$HOME/venv
ENV PATH=$VENV/bin:$PATH
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

COPY fix-permissions /usr/local/bin/fix-permissions

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get autoremove --purge -y \
    && apt-get install -y \
        python3 \
        python3-venv \
        pandoc \
        texlive-xetex \
        texlive-fonts-recommended \
        texlive-plain-generic \
        texlive-latex-extra \
        texlive-science \
        openjdk-11-jre-headless \
    && pip freeze | xargs pip uninstall -y \
    && apt-get update -y \
    && apt-get upgrade -y \
    && apt-get autoremove --purge -y \
    && apt-get autoclean -y && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && update-alternatives --config java \
    && chmod a+rx /usr/local/bin/fix-permissions \
    && useradd -l -m -s /bin/bash -N -u $NB_UID $NB_USER \
    && mkdir -p $HOME \
    && chown $NB_USER:$NB_GID $HOME \
    && chmod g+w /etc/passwd \
    && fix-permissions $HOME

USER $NB_UID

WORKDIR $HOME

RUN python3 -m venv $VENV \
    && python3 -m pip install --no-cache-dir -U pip wheel \
    && pip check \
    && rm -rf .cache
