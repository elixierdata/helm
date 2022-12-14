#!/bin/bash

export AIRFLOW_HOME="/etc/airflow"
export PATH="/opt/elixier/airflow/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

if [ "$1" == "start" ];then
    /opt/elixier/airflow/bin/airflow webserver --pid /tmp/airflow.pid
elif [ "$1" == "worker" ];then
    /opt/elixier/airflow/bin/airflow celery worker --pid /tmp/airflow-worker.pid
elif [ "$1" == "scheduler" ];then
    /opt/elixier/airflow/bin/airflow scheduler --pid /tmp/airflow-scheduler.pid
elif [ "$1" == "first-init" ];then
    /opt/elixier/airflow/bin/airflow db upgrade
    /opt/elixier/airflow/bin/airflow users create --username $DEFAULT_ADMIN --firstname $DEFAULT_ADMIN --lastname $DEFAULT_ADMIN --email $DEFAULT_ADMIN_EMAIL --password $DEFAULT_ADMIN_PASSWORD --role Admin
else
    /opt/elixier/airflow/bin/airflow "$@"
fi

