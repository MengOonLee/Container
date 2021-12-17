FROM nvidia/cuda:11.4.0-cudnn8-runtime-ubuntu20.04

ARG NB_USER=meng \
    NB_UID=1000 \
    NB_GID=100
    
ENV HOME=/home/$NB_USER
ENV VENV=$HOME/env
ENV PATH=$VENV/bin:$PATH

COPY fix-permissions /usr/local/bin/fix-permissions

RUN apt-get update -y && \
    apt-get install --no-install-recommends -y \
        build-essential \
	      python3 \
	      python3-pip \
	      python3-venv \
        wget \
        curl \
        locales && \
    curl -sL "https://deb.nodesource.com/setup_14.x" | bash - && \
    apt-get install --no-install-recommends -y nodejs && \
    apt-get upgrade -y && apt-get autoremove --purge -y && \
    apt-get autoclean -y && apt-get clean -y && \
    rm -rf /var/lib/apt/lists && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen && \
    echo "auth requisite pam_deny.so" >> /etc/pam.d/su && \
    useradd -l -m -s /bin/bash -N -u $NB_UID $NB_USER && \
    chmod a+rx /usr/local/bin/fix-permissions && \
    fix-permissions $HOME && \
    chown $NB_UID:$NB_GID $HOME
    
USER $NB_UID

WORKDIR $HOME
    
COPY requirements.txt .
    
RUN python3 -m venv $VENV && \
    python3 -m pip install --upgrade pip && \
    pip install --no-cache-dir -Ur requirements.txt && \
    jupyter labextension install jupyterlab-plotly && \
    npm cache clean --force && \
    rm -rf requirements.txt .cache/yarn
    
WORKDIR $HOME/work

EXPOSE 8888

ENTRYPOINT ["jupyter-lab", "--no-browser", "--ip=0.0.0.0", "--ServerApp.token=", "--ServerApp.password=", "--ContentsManager.allow_hidden=True"]