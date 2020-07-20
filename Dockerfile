FROM debian

# ENV LANG en_AU.UTF-8
# ENV LANGUAGE en_AU.UTF-8
# ENV LC_ALL en_AU.UTF-8
# ENV LC_CTYPE=en_AU.UTF-8
ENV TZ="Australia/Adelaide"
# ENV DEBIAN_FRONTEND "noninteractive apt-get autoremove"

WORKDIR /tmp

COPY ./*.sh /tmp/
RUN ./kickstart.sh


ENTRYPOINT ["sh", "/tmp/sleeper.sh"]

