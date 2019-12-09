#FROM arm32v7/node:buster
FROM arm32v7/alpine:latest

# Switch back to root user to install packages and configure entrypoint
USER root

EXPOSE 5050

WORKDIR /usr/src/app
COPY . .

RUN apk update \
    && apk add --update \
      bash \
      gcc \
      musl-dev \
      python3 \
      build-base \
      libffi-dev \
      python3-dev \
      tzdata \
    && pip3 install --upgrade \
      python-dateutil \
      appdaemon==4.0.0b2 \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME ["/conf"]

RUN chmod +x /usr/src/app/dockerStart.sh
ENTRYPOINT ["./dockerStart.sh"]
