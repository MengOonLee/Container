# Stage 1: Builder
FROM ubuntu:latest as builder

ARG PYTHON_VER=3.9 \
    CONDA_DIR=/opt/conda
    
ENV PATH=$CONDA_DIR/bin:$PATH

COPY requirements.yml .

RUN apt-get update -y && \
    apt-get install --no-install-recommends -y \
        build-essential \
        wget \
        curl \
        ca-certificates \
        locales && \
    curl -sL "https://deb.nodesource.com/setup_14.x" | bash - && \
    apt-get install --no-install-recommends -y nodejs && \
    apt-get upgrade -y && apt-get autoremove --purge -y && \
    apt-get autoclean -y && apt-get clean -y && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen && \
    wget -qO miniconda.sh "https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh" && \
    /bin/bash miniconda.sh -f -b -p $CONDA_DIR && \
    conda create -n notebook python=$PYTHON_VER && \
    conda env update -f requirements.yml --prune && \
    conda update --all --quiet -y && \
    conda upgrade --all --quiet -y && \
    conda clean --all -f -y && \
    rm -rf /var/lib/apt/lists miniconda.sh requirements.yml

SHELL ["conda", "run", "-n", "notebook", "/bin/bash", "-c"]    
RUN jupyter labextension install jupyterlab-plotly && \
    npm cache clean --force

# Stage 2: Runtime
FROM ubuntu:latest

ARG NB_USER=meng \
    NB_UID=1000 \
    NB_GID=100 \
    CONDA_DIR=/opt/conda

ENV HOME=/home/$NB_USER \
    PATH=$CONDA_DIR/bin:$PATH

COPY --from=builder $CONDA_DIR/. $CONDA_DIR/

COPY fix-permissions /usr/local/bin/fix-permissions

RUN apt-get update -y && \
    apt-get install --no-install-recommends -y \
        wget \
        curl \
        ca-certificates && \
    apt-get upgrade -y && apt-get autoremove --purge -y && \
    apt-get autoclean -y && apt-get clean -y && \
    chmod a+rx /usr/local/bin/fix-permissions && \
    echo "auth requisite pam_deny.so" >> /etc/pam.d/su && \
    useradd -l -m -s /bin/bash -N -u $NB_UID $NB_USER && \
    chown $NB_USER:$NB_GID $CONDA_DIR && \
    chmod g+w /etc/passwd && \
    fix-permissions $HOME && \
    fix-permissions $CONDA_DIR && \
    mkdir -p $HOME/work && \
    rm -rf $HOME/.cache/yarn

USER $NB_UID

WORKDIR $HOME/work

EXPOSE 8888

SHELL ["conda", "run", "-n", "notebook", "/bin/bash", "-c"]

ENTRYPOINT ["conda", "run", "--no-capture-output", "-n", "notebook", "jupyter-lab", "--no-browser", "--ip='0.0.0.0'", "--ServerApp.token=''", "--ServerApp.password=''", "--ContentsManager.allow_hidden=True"]
