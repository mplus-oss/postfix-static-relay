FROM debian:bullseye-slim
RUN set -ex; \
    apt update; \
    apt install --no-install-recommends postfix postfix-pcre libsasl2-modules gettext-base mailutils ca-certificates -y; \
    echo mail.example.com > /etc/mailname
COPY ./entrypoint.sh /entrypoint.sh
COPY ./main.cf.template /etc/postfix/
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["start-fg"]