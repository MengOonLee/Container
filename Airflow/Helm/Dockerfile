From apache/airflow:2.2.1-python3.8

USER root
RUN apt-get update -yqq \
    && apt-get install -yqq --no-install-recommends \
        build-essential \
    && apt-get upgrade -yqq \
    && apt-get autoremove --purge -yqq \
    && apt-get autoclean -yqq \
    && rm -rf /var/lib/apt/lists/*

COPY --chown=airflow:root test_dag.py /opt/airflow/dags/

USER airflow
COPY requirements.txt .
RUN python3 -m pip install --no-cache-dir -qU pip wheel setuptools \
    && python3 -m pip install --no-cache-dir -Ur requirements.txt \
    && rm -rf requirements.txt
