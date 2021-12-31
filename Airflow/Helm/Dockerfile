FROM apache/airflow:latest-python3.8

USER root

RUN apt-get update -yqq \
    && apt-get install -yqq --no-install-recommends \
        build-essential \
    && apt-get upgrade -yqq \
    && apt-get autoremove --purge -yqq \
    && apt-get autoclean -yqq \
    && rm -rf /var/lib/apt/lists

USER airflow
COPY requirements.txt .

RUN python3 -m pip install --upgrade pip \
    && python3 -m pip install --no-cache-dir -qUr requirements.txt \
    && pip check \
    && rm -rf requirements.txt
