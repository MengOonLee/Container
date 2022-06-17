FROM tensorflow/tensorflow:latest-gpu

COPY requirements.txt .

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
        openjdk-11-jre-headless \
    && curl -fsSL "https://deb.nodesource.com/setup_lts.x" | bash - \
    && apt install -y nodejs \
    && apt upgrade -y && apt autoremove --purge -y \
    && apt autoclean -y && apt clean -y \
    && rm -rf /var/lib/apt/lists \
    && update-alternatives --config java \
    && python3 -m pip install --no-cache-dir -U pip wheel \
    && pip install --no-cache-dir -Ur requirements.txt \
    && jupyter labextension install jupyterlab-plotly \
    && npm cache clean --force \
    && rm -rf requirements.txt

EXPOSE 8888

ENTRYPOINT ["jupyter-lab", "--no-browser", "--allow-root", "--ip=0.0.0.0", "--ServerApp.token=", "--ServerApp.password=", "--ContentsManager.allow_hidden=True"]