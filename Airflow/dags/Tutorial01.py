from datetime import datetime
from airflow.models import DAG
from airflow.operators.bash import BashOperator

default_args = {
    'start_date': datetime(2021, 7, 30),
    'schedule_interval': '15 8,16 * * *'
}
with DAG('Tutorial01', default_args=default_args) as dag:
# Define the tasks    
    task01 = BashOperator(
        task_id='1stecho',
        bash_command='echo $PWD'
    )
    task02 = BashOperator(
        task_id='run-script',
        bash_command='Tutorial/Tutorial01.sh'
    )
    task03 = BashOperator(
        task_id='2ndecho',
        bash_command='ls && echo'
    )
    # Set task01 to run before task02
    task01 >> task02
    # Set task03 to run before task02
    task02 << task03