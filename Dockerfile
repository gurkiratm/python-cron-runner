FROM alpine:latest

LABEL Version="1.0"
LABEL description="Generic Python Cron Runner-Schedule Any Script with Environment-Driven Cron"
LABEL maintainer="Gurkirat Singh"
LABEL maintainer_email="gurkiratsingh8321@gmail.com"

WORKDIR /app

COPY entrypoint.sh ./

RUN apk update && \
    apk add --no-cache python3 py3-pip &&\
    rm -rf /var/cache/apk/*

RUN chmod +x /app/entrypoint.sh
ENTRYPOINT ["sh", "/app/entrypoint.sh"]