# Description: Dockerfile cluster utils service
FROM debian:bookworm-slim

# Metadata
ARG VERSION=latest
LABEL maintainer="David Binney <donkeysoft@gmail.com>"
LABEL version=$VERSION
LABEL description="This is a utility for testing within cluster or networks and not needing to install tooling"

ENV TZ="Australia/Adelaide"

WORKDIR /app

COPY ./*.sh /app/

# Update and install basic tools
RUN apt-get update && apt-get install -y \
    dnsutils netcat-openbsd curl wget tar gnupg vim tmux zsh screenfetch && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install PostgreSQL client and Redis tools
RUN apt-get update && apt-get install -y \
    postgresql-client redis-tools && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Git, Go, Node.js, and npm
RUN apt-get update && apt-get install -y \
    git golang nodejs npm && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# # Install MongoDB tools
# RUN curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor && \
#     echo "deb [ signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] http://repo.mongodb.org/apt/debian bookworm/mongodb-org/7.0 main" | tee /etc/apt/sources.list.d/mongodb-org-7.0.list && \
#     apt-get update && apt-get install -y mongodb-org-tools && \
#     apt-get clean && \
#     rm -rf /var/lib/apt/lists/*

RUN ./kickstart.sh

ENTRYPOINT ["zsh", "/app/sleeper.sh"]