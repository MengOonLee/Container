From apache/airflow:2.1.2-python3.8

LABEL maintainer="Meng Oon Lee <darklemon2000@gmail.com>"

USER root
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
        build-essential && \
    apt-get upgrade -y && \
    apt-get autoremove --purge -y && \
    apt-get autoclean -y && \
    rm -rf /var/lib/apt/lists/*

USER airflow
RUN python -m pip install --upgrade pip

COPY requirements.txt .

RUN pip install -r requirements.txt --no-cache-dir
