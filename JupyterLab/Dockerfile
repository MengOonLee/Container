FROM nvidia/cuda:11.2.0-base-ubuntu20.04

LABEL maintainer="Meng Oon Lee <darklemon2000@gmail.com>"
ENV NB_USER="meng"
ENV NB_UID="1000"
ENV NB_GID="100"

USER root
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
        build-essential \
        wget \
        curl \
        ca-certificates \
        locales \
        texlive-xetex \
        texlive-fonts-recommended \
        texlive-plain-generic \
        texlive-latex-extra \
        texlive-publishers \
        texlive-science \
        pandoc && \
    curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y --no-install-recommends nodejs && \
    apt-get upgrade -y && apt-get autoremove --purge -y && \
    apt-get autoclean -y && apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen
    
ENV CONDA_DIR=/opt/conda \
    HOME="/home/${NB_USER}"
    
COPY fix-permissions /usr/local/bin/fix-permissions
RUN chmod a+rx /usr/local/bin/fix-permissions && \
    echo "auth requisite pam_deny.so" >> /etc/pam.d/su && \
    useradd -l -m -s /bin/bash -N -u "${NB_UID}" "${NB_USER}" && \
    mkdir -p "${CONDA_DIR}" && \
    chown "${NB_USER}:${NB_GID}" "${CONDA_DIR}" && \
    chmod g+w /etc/passwd && \
    fix-permissions "${HOME}" && \
    fix-permissions "${CONDA_DIR}"

USER "${NB_UID}"

WORKDIR /tmp

ENV PATH="${CONDA_DIR}/bin:${PATH}" \
    CONDA_ENV="${CONDA_DIR}/envs/notebook"

RUN mkdir -p "${HOME}/work" && \
    fix-permissions "${HOME}" && \
    wget -qO ./miniconda.sh "https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"
    
COPY requirements.yml ./requirements.yml
    
RUN /bin/bash ./miniconda.sh -f -b -p "${CONDA_DIR}" && \
    rm ./miniconda.sh && \
    conda update --all --quiet --yes && \
    conda clean --all -f -y && \
    rm -rf "${HOME}/.cache/yarn" && \
    fix-permissions "${HOME}" && \
    fix-permissions "${CONDA_DIR}" && \
    conda create -n notebook python=3.8 && \
    conda env update -f ./requirements.yml --prune

ENV PATH="${CONDA_ENV}/bin:$PATH"

# Make RUN commands use the new environment:
SHELL ["conda", "run", "-n", "notebook", "/bin/bash", "-c"]

RUN jupyter labextension install jupyterlab-plotly && \
    conda upgrade --all --quiet --yes && \
    conda clean --all -f -y && \
    npm cache clean --force && \
    rm -rf "${HOME}/.cache/yarn" && \
    fix-permissions "${HOME}" && \
    fix-permissions "${CONDA_DIR}"

WORKDIR "${HOME}"

EXPOSE 8888

ENTRYPOINT ["conda", "run", "--no-capture-output", "-n", "notebook", "jupyter-lab", "--no-browser", "--ip='0.0.0.0'", "--ServerApp.token=''", "--ServerApp.password=''", "--ContentsManager.allow_hidden=True"]