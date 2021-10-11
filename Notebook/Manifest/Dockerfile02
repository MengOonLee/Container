FROM ubuntu:latest

LABEL maintainer="Meng Oon Lee <darklemon2000@gmail.com>"

# The Python version of the Docker must match the Python version
ARG NB_USER=meng \
    NB_UID=1000 \
    NB_GID=100 \
    NB_ENV=notebook \
    PYTHON_VER=3 \
    CONDA_DIR=/opt/conda

# Update PATH so we find Conda installations.
ENV DEBIAN_FRONTEND=noninteractive \
    HOME=/home/$NB_USER \
    PATH=$CONDA_DIR/bin:$PATH

COPY fix-permissions /usr/local/bin/fix-permissions
COPY requirements.yml .

RUN apt-get update -y && \
    apt-get install -y \
        build-essential \
        wget \
        curl \
        ca-certificates \
        locales && \
    curl -sL "https://deb.nodesource.com/setup_14.x" | bash - && \
    apt-get install -y nodejs && \
    apt-get upgrade -y && apt-get autoremove --purge -y && \
    apt-get autoclean -y && apt-get clean -y && \
    rm -rf /var/lib/apt/lists && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen && \
    chmod a+rx /usr/local/bin/fix-permissions && \
    echo "auth requisite pam_deny.so" >> /etc/pam.d/su && \
    useradd -l -m -s /bin/bash -N -u $NB_UID $NB_USER && \
    # The NVIDIA image doesn't come with Python pre-installed.
    # We use Miniconda to install the Python version fo our choice.
    wget -qO miniconda.sh "https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh" && \
    /bin/bash miniconda.sh -f -b -p $CONDA_DIR && \
    # Create a Notebook environment with desired Python version
    conda create -n $NB_ENV python=$PYTHON_VER && \
    # Install necessary Python package
    conda env update -f requirements.yml --prune && \
    conda update --all --quiet -y && \
    conda upgrade --all --quiet -y && \
    conda clean --all -f -y && \
    npm cache clean --force && \
    chown $NB_USER:$NB_GID $CONDA_DIR && \
    chmod g+w /etc/passwd && \
    fix-permissions $HOME && \
    fix-permissions $CONDA_DIR && \
    rm -rf miniconda.sh requirements.yml get-pip.py $HOME/.cache/yarn

USER $NB_UID

# Make RUN commands use the new environment:
SHELL ["conda", "run", "-n", "notebook", "/bin/bash", "-c"]
    
RUN jupyter labextension install jupyterlab-plotly && \
    mkdir -p $HOME/work

WORKDIR $HOME/work

EXPOSE 8888

ENTRYPOINT ["conda", "run", "--no-capture-output", "-n", "notebook", "jupyter-lab", "--no-browser", "--ip='0.0.0.0'", "--ServerApp.token=''", "--ServerApp.password=''", "--ContentsManager.allow_hidden=True"]
