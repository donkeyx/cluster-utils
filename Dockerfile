# Description: Dockerfile for the Sleeper service
FROM debian:buster-slim

# Metadata
ARG VERSION=latest
LABEL maintainer="David Binney <donkeysoft@gmail.com>"
LABEL version=$VERSION
LABEL description="This container is a utility for testing within cluster or networks and not needing to install tooling"

ENV TZ="Australia/Adelaide"

WORKDIR /app

COPY ./*.sh /app/

# Update and install basic tools
RUN apt-get update && apt-get install -y \
    dnsutils netcat curl wget tar gnupg vim tmux zsh screenfetch && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install database clients
RUN apt-get update && apt-get install -y \
    postgresql-client redis-tools && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install programming languages and tools
RUN apt-get update && apt-get install -y \
    git golang && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
    nodejs npm && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install MongoDB tools
RUN wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | apt-key add - && \
    echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/4.4 main" | tee /etc/apt/sources.list.d/mongodb-org-4.4.list && \
    apt-get update && apt-get install -y mongodb-org-tools && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN ./kickstart.sh

ENTRYPOINT ["zsh", "/app/sleeper.sh"]