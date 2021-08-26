From apache/airflow:2.1.3-python3.8

COPY requirements.txt .

RUN apt-get update -y && \
    apt-get install -y \
        build-essential && \
    apt-get upgrade -y && \
    apt-get autoremove --purge -y && \
    rm -rf /var/lib/apt/lists/* && \
    python3 -m pip install -U pip wheel && \
    pip install -Ur requirements.txt --no-cache-dir &&
    rm -rf requirements.txt
