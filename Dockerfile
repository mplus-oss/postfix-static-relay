FROM debian:bullseye-slim
LABEL org.opencontainers.image.authors="Syahrial Agni Prasetya <syahrial@mplus.software>"
LABEL org.opencontainers.image.licenses="Apache-2.0"
LABEL org.opencontainers.image.vendor="M+ Software"
LABEL org.opencontainers.image.title="Postfix Static Relay"
LABEL org.opencontainers.image.description="Postfix relay mail server with static relayhost"
RUN set -ex; \
    apt update; \
    apt install --no-install-recommends postfix postfix-pcre libsasl2-modules gettext-base mailutils ca-certificates -y; \
    echo mail.example.com > /etc/mailname
COPY ./entrypoint.sh /entrypoint.sh
COPY ./main.cf.template /etc/postfix/
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["start-fg"]