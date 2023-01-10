#!/bin/sh

if [ -z "$POSTFIX_RELAY_HOST" ]; then
    echo "POSTFIX_RELAY_HOST is not set"
    exit 1
fi

if [ -z "$POSTFIX_RELAY_USER" ]; then
    echo "POSTFIX_RELAY_USER is not set"
    exit 1
fi

if [ -z "$POSTFIX_RELAY_PASSWORD" ]; then
    echo "POSTFIX_RELAY_PASSWORD is not set"
    exit 1
fi

if [ -z "$POSTFIX_FROM_NAME" ]; then
    echo "POSTFIX_FROM_NAME is not set"
    exit 1
fi

if [ -z "$POSTFIX_FROM_ADDRESS" ]; then
    echo "POSTFIX_FROM_ADDRESS is not set"
    exit 1
fi


envsubst < /etc/postfix/main.cf.template > /etc/postfix/main.cf
cp /etc/resolv.conf /var/spool/postfix/etc/resolv.conf
echo "${POSTFIX_RELAY_HOST} ${POSTFIX_RELAY_USER}:${POSTFIX_RELAY_PASSWORD}" > /etc/postfix/sasl_passwd
chmod 600 /etc/postfix/sasl_passwd
postmap /etc/postfix/sasl_passwd

exec /usr/sbin/postfix -c /etc/postfix start-fg