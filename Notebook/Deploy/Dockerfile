FROM nvidia/cuda:11.4.0-base-ubuntu20.04

LABEL maintainer="Meng Oon Lee <darklemon2000@gmail.com>"
ENV NB_USER="meng" \
    NB_UID="1000" \
    NB_GID="100" \
    NB_ENV="notebook" \
    PYTHON_VER=3.8 \
    DEBIAN_FRONTEND=noninteractive \
    CONDA_DIR=/opt/conda \
    JAVA_HOME="/usr/lib/jvm/default-java"
    
ENV HOME="/home/${NB_USER}" \
    PATH="${CONDA_DIR}/bin:${PATH}"

COPY fix-permissions /usr/local/bin/fix-permissions
    
USER root
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
        build-essential \
        wget \
        curl \
        ca-certificates \
        locales \
        default-jre \
        default-jdk \
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
    rm -rf /var/lib/apt/lists && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen && \
    chmod a+rx /usr/local/bin/fix-permissions && \
    echo "auth requisite pam_deny.so" >> /etc/pam.d/su && \
    useradd -l -m -s /bin/bash -N -u "${NB_UID}" "${NB_USER}" && \
    mkdir -p "${CONDA_DIR}" && \
    chown "${NB_USER}:${NB_GID}" "${CONDA_DIR}" && \
    chmod g+w /etc/passwd
    
USER "${NB_UID}"

WORKDIR "${HOME}"

COPY requirements.yml .

RUN wget -qO miniconda.sh "https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh" && \
    /bin/bash miniconda.sh -f -b -p "${CONDA_DIR}" && \
    conda create -n "${NB_ENV}" python="${PYTHON_VER}" && \
    conda env update -f requirements.yml --prune && \
    rm miniconda.sh requirements.yml
    
# Make RUN commands use the new environment:
SHELL ["conda", "run", "-n", "notebook", "/bin/bash", "-c"]
    
RUN jupyter labextension install jupyterlab-plotly && \
    conda update --all --quiet --yes && \
    conda upgrade --all --quiet --yes && \
    conda clean --all -f -y && \
    npm cache clean --force && \
    rm -rf "${HOME}/.cache/yarn" && \
    fix-permissions "${HOME}" && \
    fix-permissions "${CONDA_DIR}" && \
    mkdir -p "${HOME}/work"
   
WORKDIR "${HOME}/work"

EXPOSE 8888

ENTRYPOINT ["conda", "run", "--no-capture-output", "-n", "notebook", "jupyter-lab", "--no-browser", "--ip='0.0.0.0'", "--ServerApp.token=''", "--ServerApp.password=''", "--ContentsManager.allow_hidden=True"]