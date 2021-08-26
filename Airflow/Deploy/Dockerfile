From apache/airflow:2.1.3-python3.8

USER root
RUN apt-get update -y && \
    apt-get install -y \
        build-essential && \
    apt-get upgrade -y && \
    apt-get autoremove --purge -y && \
    rm -rf /var/lib/apt/lists/*
    
USER airflow
COPY requirements.txt .
RUN python3 -m pip install -U pip wheel && \
    pip install -Ur requirements.txt --no-cache-dir && \
    rm -rf requirements.txt
