#!/usr/bin/env sh

# Start busybox syslog with redirect to stdout
echo "Start syslogd ..."
/sbin/syslogd -s 0 -O -

# Create aliases db
echo "Create aliases ..."
/usr/sbin/postalias -c /etc/mailer lmdb:/etc/mailer/aliases

# Start opendkim daemon
echo "Start opendkim ..."
/usr/sbin/opendkim -d "$DKIM_DOMAIN" -k "$DKIM_KEYFILE" -s "$DKIM_SELECTOR" -x /etc/mailer/opendkim.conf

# Wait for opendkim
/bin/sleep 2

# Start Postfix MTA
/usr/sbin/postfix -c /etc/mailer start

# Hold script run
exec /bin/sleep inf
