FROM nvidia/cuda:11.4.0-cudnn8-runtime-ubuntu20.04

ARG NB_USER=meng \
    NB_UID=1000 \
    NB_GID=100

ENV HOME=/home/$NB_USER
ENV PATH=$HOME/env/bin:$PATH

COPY requirements.txt .

COPY fix-permissions /usr/local/bin/fix-permissions

RUN apt-get update -y && \
    apt-get install --no-install-recommends -y \
    	build-essential \
    	python3 \
    	python3-venv \
        wget \
        curl \
        locales && \
    curl -sL "https://deb.nodesource.com/setup_14.x" | bash - && \
    apt-get install --no-install-recommends -y nodejs && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen && \
    wget -qO get-pip.py "https://bootstrap.pypa.io/get-pip.py" && \
    python3 get-pip.py && \
    echo "auth requisite pam_deny.so" >> /etc/pam.d/su && \
    useradd -l -m -s /bin/bash -N -u $NB_UID $NB_USER && \
    chmod g+w /etc/passwd && \
    python3 -m venv $HOME/env && \
    python3 -m pip install --upgrade pip && \
    pip install --no-cache-dir -Ur requirements.txt && \
    jupyter labextension install jupyterlab-plotly && \
    apt-get upgrade -y && apt-get autoremove --purge -y && \
    apt-get autoclean -y && apt-get clean -y && \
    chmod a+rx /usr/local/bin/fix-permissions && \
    fix-permissions $HOME && \
    chown $NB_USER:$NB_GID $HOME/env && \
    fix-permissions $HOME/env && \
    mkdir -p $HOME/work && \
    npm cache clean --force && \
    rm -rf $HOME/.cache/yarn /var/lib/apt/lists requirements.txt get-pip.py

USER $NB_UID

WORKDIR $HOME/work

EXPOSE 8888

ENTRYPOINT ["jupyter-lab", "--no-browser", "--ip='0.0.0.0'", "--ServerApp.token=''", "--ServerApp.password=''", "--ContentsManager.allow_hidden=True"]
