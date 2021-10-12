# Stage 1: Builder
FROM python:3.8-slim as builder

ENV PATH=./env/bin:$PATH

COPY requirements.txt .

RUN apt-get update -y && \
    apt-get install --no-install-recommends -y \
        build-essential \
        curl && \
    curl -sL "https://deb.nodesource.com/setup_14.x" | bash - && \
    apt-get install --no-install-recommends -y nodejs && \
    apt-get upgrade -y && apt-get autoremove --purge -y && \
    apt-get autoclean -y && apt-get clean -y && \
    python3 -m venv env && \
    python3 -m pip install --upgrade pip && \
    pip install --no-cache-dir -Ur requirements.txt && \
    jupyter labextension install jupyterlab-plotly && \
    npm cache clean --force && \
    rm -rf /var/lib/apt/lists requirements.txt

# Stage 2: Runtime
FROM nvidia/cuda:11.4.0-cudnn8-runtime-ubuntu20.04

ARG NB_USER=meng \
    NB_UID=1000 \
    NB_GID=100

ENV HOME=/home/$NB_USER \
    PATH=$HOME/env/bin:$PATH
    
WORKDIR $HOME

COPY fix-permissions /usr/local/bin/fix-permissions

RUN apt-get update -y && \
    apt-get install --no-install-recommends -y \
    	python3.8 \
    	python3-venv \
        wget \
        curl \
        locales && \
    python3 -m venv env && \
    apt-get upgrade -y && apt-get autoremove --purge -y && \
    apt-get autoclean -y && apt-get clean -y && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen && \
    chmod a+rx /usr/local/bin/fix-permissions && \
    echo "auth requisite pam_deny.so" >> /etc/pam.d/su && \
    useradd -l -m -s /bin/bash -N -u $NB_UID $NB_USER && \
    chmod g+w /etc/passwd && \
    fix-permissions $HOME && \
    mkdir -p $HOME/work && \
    rm -rf $HOME/.cache/yarn
    
COPY --from=builder /env/lib/python3.8/site-packages $HOME/env/lib/python3.8/site-packages

USER $NB_UID

WORKDIR $HOME/work

EXPOSE 8888

ENTRYPOINT ["jupyter-lab", "--no-browser", "--ip='0.0.0.0'", "--ServerApp.token=''", "--ServerApp.password=''", "--ContentsManager.allow_hidden=True"]
