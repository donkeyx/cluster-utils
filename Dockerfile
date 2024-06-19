FROM debian:bookworm-slim

# Metadata
ARG VERSION=latest
LABEL maintainer="David Binney <donkeysoft@gmail.com>"
LABEL version=$VERSION
LABEL description="This is a utility for testing within cluster or networks and not needing to install tooling"

ENV TZ="Australia/Adelaide"

WORKDIR /app

COPY ./*.sh /app/

# Update and install all required tools in one RUN command to minimize layers
RUN apt-get update && apt-get install -y --no-install-recommends \
    dnsutils netcat-openbsd curl wget tar gnupg vim tmux zsh \
    postgresql-client redis-tools git golang nodejs npm && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Uncomment and modify the MongoDB tools installation if needed
# RUN curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | gpg --dearmor -o /usr/share/keyrings/mongodb-server-7.0.gpg && \
#     echo "deb [signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg] http://repo.mongodb.org/apt/debian bookworm/mongodb-org/7.0 main" | tee /etc/apt/sources.list.d/mongodb-org-7.0.list && \
#     apt-get update && apt-get install -y --no-install-recommends mongodb-org-tools && \
#     apt-get clean && \
#     rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN ./kickstart.sh

ENTRYPOINT ["zsh", "/app/sleeper.sh"]
