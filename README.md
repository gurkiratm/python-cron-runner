# 🕒 Python Cron Runner

Run any Python script on a custom cron schedule with environment-based control and logging.

Docker Image: [`gurkiratm/python-cron`](https://hub.docker.com/r/gurkiratm/python-cron)

Pull command:  
```
docker pull gurkiratm/python-cron:latest
```

---
 
## 📦 About

This image runs any user-supplied Python script on a recurring schedule using `cron`, with parameters passed via environment variables. It installs dependencies at runtime and logs output to a configurable or timestamped file inside the container.

---

## 🚀 Features

- ✅ Run any script via `PYTHON_SCRIPT_PATH`
- ✅ Schedule via `CRON_SCHEDULE` (default: `0 9 * * *`)
- ✅ Logs to dynamic or custom `LOG_FILE`
- ✅ Virtualenv auto-created at `/app/.venv`
- ✅ Installs `requirements.txt` via `REQUIREMENTS_FILE` (default: `/app/requirements.txt`)
- ✅ Lightweight Alpine base image
- ✅ Uses `busybox crond` running in foreground for clean logs

---

## 🔧 Environment Variables

| Variable             | Required | Description                                                                 |
|----------------------|----------|-----------------------------------------------------------------------------|
| `PYTHON_SCRIPT_PATH` | ✅ Yes   | Full path to the Python script inside the container                         |
| `CRON_SCHEDULE`      | ❌ No    | Cron format schedule (default: `0 9 * * *`)                                 |
| `LOG_FILE_PATH`           | ❌ No    | Log file name (Default: `/app/script_python_dYYYYMMDD_tHHMMSS.log`)       |
| `REQUIREMENTS_FILE`  | ❌ No    | Path to `requirements.txt` (Default: `/app/requirements.txt` : empty)               |

---

## 📁 Volume Mounts

Mount your Python script and any inputs:

```bash
-v $(pwd)/scripts:/data:Z
```

---

## 📄 Example Usage

```
docker run --rm \
  -v $(pwd)/scripts:/data:Z \
  -e PYTHON_SCRIPT_PATH="/data/myscript.py" \
  -e CRON_SCHEDULE="*/10 * * * *" \
  -e REQUIREMENTS_FILE="/data/requirements.txt" \
  -e LOG_FILE_PATH="myscript.logs" \
  gurkiratm/python-cron
```

---

## 📝 Logs
Script output will be logged to:

`${LOG_FILE_PATH}` if provided

Or the default: `/app/script_python_dYYYYMMDD_tHHMMSS.log`

To view logs:
```
docker exec <container-name> cat <LOG-FILE-PATH>
docker logs <container-name>
```

---
## 🛠 Build Locally 

```docker build -t python-cron-runner . ```

---

## 👨‍💻 Maintainer
Gurkirat Singh
📧 gurkiratsingh8321@gmail.com
