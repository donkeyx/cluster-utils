# Description: Dockerfile for the Sleeper service
FROM debian:slim

# Metadata
ARG VERSION=latest
LABEL maintainer="David Binney <donkeysoft@gmail.com>"
LABEL version=$VERSION
LABEL description="This is a custom Docker image for the Sleeper service."

ENV TZ="Australia/Adelaide"

WORKDIR /app

COPY ./*.sh /app/
RUN apt-get update && apt-get install -y \
    dnsutils netcat curl \
    git jq vim tmux zsh \
    postgresql-client redis-tools mongodb-tools \
    git nodejs npm golang && \
    npm install -g yarn && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    chsh -s $(which zsh)

RUN ./kickstart.sh

ENTRYPOINT ["sh", "/app/sleeper.sh"]