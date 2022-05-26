FROM tensorflow/tensorflow:latest-gpu

ARG NB_USER=meng \
    NB_UID=1000 \
    NB_GID=100
    
ENV HOME=/home/$NB_USER
ENV VENV=$HOME/env
ENV PATH=$VENV/bin:$PATH

COPY fix-permissions /usr/local/bin/fix-permissions

RUN apt update -y \
    && apt upgrade -y \
    && apt autoremove --purge -y \
    && apt install -y \
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
    && curl -fsSL "https://deb.nodesource.com/setup_lts.x" | bash - \
    && apt install -y nodejs \
    && apt upgrade -y && apt autoremove --purge -y \
    && apt autoclean -y && apt clean -y \
    && rm -rf /var/lib/apt/lists \
    && echo "auth requisite pam_deny.so" >> /etc/pam.d/su \
    && useradd -l -m -s /bin/bash -N -u $NB_UID $NB_USER \
    && chmod a+rx /usr/local/bin/fix-permissions \
    && fix-permissions $HOME \
    && chown $NB_UID:$NB_GID $HOME

USER $NB_UID

WORKDIR $HOME

COPY requirements.txt .

RUN python3 -m venv $VENV \
    && python3 -m pip install --no-cache-dir -U pip wheel \
    && pip install --no-cache-dir -Ur requirements.txt \
    && pip check \
    && jupyter labextension install jupyterlab-plotly \
    && npm cache clean --force \
    && rm -rf requirements.txt .cache

WORKDIR $HOME/Work

EXPOSE 8888

ENTRYPOINT ["jupyter-lab", "--no-browser", "--ip=0.0.0.0", "--ServerApp.token=", "--ServerApp.password=", "--ContentsManager.allow_hidden=True"]