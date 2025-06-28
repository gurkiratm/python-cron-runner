#!/bin/bash

echo "[Info] Intializing entrypoint script..."

if [ -z "$PYTHON_SCRIPT_PATH" ]; then
    echo "[Error] PYTHON_SCRIPT_PATH is not set. Exiting..."
    exit 1
elif [ ! -f "$PYTHON_SCRIPT_PATH" ]; then
    echo "[Error] $PYTHON_SCRIPT_PATH does not exist. Exiting..."
    exit 1
fi

if [ -z "$CRON_SCHEDULE" ]; then
    echo "[Info] CRON_SCHEDULE is not set. Defaulting to '0 9 * * *'."
    CRON_SCHEDULE="0 9 * * *"
fi

: "${LOG_FILE_PATH:=/app/script_python_$(date '+d%Y%m%d_t%H%M%S').log}"

if [ -z "$REQUIREMENTS_FILE" ]; then
    echo "[Info] REQUIREMENTS_FILE is not set. Defaulting to 'requirements.txt'."
    touch /app/requirements.txt
    REQUIREMENTS_FILE="/app/requirements.txt"
fi

# Create a virtual environment and install dependencies
echo "[Info] Creating virtual environment and installing dependencies..."
python3 -m venv /app/.venv  && . /app/.venv/bin/activate && pip install -r ${REQUIREMENTS_FILE}

echo "[Info] CRON_SCHEDULE is set to: $CRON_SCHEDULE"
echo "[Info] Setting up cron job..."
echo -e "${CRON_SCHEDULE} /app/.venv/bin/python3 ${PYTHON_SCRIPT_PATH} >> ${LOG_FILE_PATH}2>&1\n" > /etc/crontabs/root

exec busybox crond -f -L /dev/stdout