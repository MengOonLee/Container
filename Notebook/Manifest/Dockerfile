ARG BASE=tensorflow/tensorflow:latest-gpu
FROM $BASE

ARG NB_USER="meng"
ARG NB_UID="1000"
ARG NB_GID="100"

ENV SHELL=/bin/bash
ENV NB_USER="${NB_USER}"
ENV NB_UID=${NB_UID}
ENV NB_GID=${NB_GID}
ENV HOME="/home/${NB_USER}"
ENV VENV="${HOME}/venv"
ENV PATH="${VENV}/bin:${PATH}"

COPY fix-permissions /usr/local/bin/fix-permissions

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get autoremove --purge -y \
    && apt-get install -y --no-install-recommends \
        build-essential \
        python3 \
        python3-dev \
        python3-pip \
        python3-venv \
        wget \
        curl \
        git \
        pandoc \
        texlive-xetex \
        texlive-fonts-recommended \
        texlive-plain-generic \
        texlive-latex-extra \
        texlive-science \
        openjdk-11-jre-headless \
    && curl -fsSL "https://deb.nodesource.com/setup_lts.x" | bash - \
    && apt-get install -y --no-install-recommends \ 
        nodejs \
    && pip uninstall -y -r <(pip freeze) \
    && apt-get upgrade -y && apt-get autoremove --purge -y \
    && apt-get autoclean -y && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && update-alternatives --config java \
    && chmod a+rx /usr/local/bin/fix-permissions \
    && useradd -l -m -s /bin/bash -N -u "${NB_UID}" "${NB_USER}" \
    && mkdir -p "${HOME}" \
    && chown "${NB_USER}:${NB_GID}" "${HOME}" \
    && chmod g+w /etc/passwd \
    && fix-permissions "${HOME}"

USER ${NB_UID}

WORKDIR "${HOME}"

COPY requirements.txt .

RUN python3 -m venv $VENV \
    && python3 -m pip install --no-cache-dir -U pip wheel \
    && pip install --no-cache-dir -Ur requirements.txt \
    && pip check \
    && jupyter labextension install jupyterlab-plotly \
    && npm cache clean --force \
    && jupyter lab clean \
    && rm -rf requirements.txt .cache/yarn

WORKDIR "${HOME}/work"

EXPOSE 8888

ENTRYPOINT ["jupyter-lab", "--no-browser", "--ip=0.0.0.0", "--ServerApp.token=", "--ServerApp.password=", "--ContentsManager.allow_hidden=True"]