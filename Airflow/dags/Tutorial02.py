from datetime import datetime
from time import sleep
from airflow.models import DAG
from airflow.operators.python import PythonOperator
from airflow.operators.email import EmailOperator

default_args = {
    'start_date': datetime(2021, 7, 30),
    'schedule_interval': '0 10 * * *'
}

def printme():
    print("This goes in the logs!")
    
def sleep_func(length_of_time):
    sleep(length_of_time)

with DAG('Tutorial02', default_args=default_args) as dag:
# Define the tasks    
    task01 = PythonOperator(
        task_id='print',
        python_callable=printme
    )
    task02 = PythonOperator(
        task_id='sleep',
        python_callable=sleep_func,
        op_kwargs={'length_of_time': 5}
    )
    task03 = EmailOperator(
        task_id='email',
        to='darklemonlee@yahoo.co.uk',
        subject='Automated email from airflow',
        html_content='Test successfully!'
    )
    
    task01 >> [task02, task03]