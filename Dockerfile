FROM alpine

# ENV LANG en_AU.UTF-8
# ENV LANGUAGE en_AU.UTF-8
# ENV LC_ALL en_AU.UTF-8
# ENV LC_CTYPE=en_AU.UTF-8
ENV TZ="Australia/Adelaide"
# ENV DEBIAN_FRONTEND "noninteractive apt-get autoremove"

WORKDIR /app

COPY ./*.sh /app/
RUN apk add --no-cache \
    bind-tools netcat-openbsd curl \
    git jq vim tmux zsh \
    postgresql-client redis mongodb-tools \
    git nodejs

RUN ./kickstart.sh


ENTRYPOINT ["sh", "/app/sleeper.sh"]

