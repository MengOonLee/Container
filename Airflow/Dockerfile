From apache/airflow:2.1.2-python3.8

LABEL maintainer="Meng Oon Lee <darklemon2000@gmail.com>"

ENV AIRFLOW_VERSION=2.1.2 \
    PYTHON_VERSION=3.8 \
    VIRTUAL_ENV=./venv

ENV PATH="$VIRTUAL_ENV/bin:$PATH" \
    CONSTRAINT_URL="https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-${PYTHON_VERSION}.txt"

COPY requirements.txt requirements.txt

RUN python3 -m venv $VIRTUAL_ENV && \
    python3 -m pip install -U pip && \
    pip install -Ur requirements.txt --constraint "${CONSTRAINT_URL}"
    
COPY dags $AIRFLOW_HOME/dags