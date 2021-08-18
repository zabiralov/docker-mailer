#!/usr/bin/env sh

# Start busybox syslog with redirect to stdout
echo -n "Start syslogd ... "
if /sbin/syslogd -s 0 -O -
then echo OK
else echo FAIL
fi


# Create aliases db
echo -n "Create aliases ... "
if /usr/sbin/postalias -c /etc/mailer lmdb:/etc/mailer/aliases
then echo OK
else echo FAIL
fi


# Create sasldb2
echo -n "Create sasldb2 database ... "
if echo -n 'AHmOi2CCVtchGeG' | /usr/sbin/saslpasswd2 -f /etc/sasl2/sasldb2 -u "$DKIM_DOMAIN" -p "$RELAY_USER"
then echo OK
else echo FAIL
fi


# Start opendkim daemon
echo "Start opendkim ... "
if /usr/sbin/opendkim -d "$DKIM_DOMAIN" -k "$DKIM_KEYFILE" -s "$DKIM_SELECTOR" -x /etc/mailer/opendkim.conf
then echo OK
else echo FAIL
fi


# Wait for opendkim
/bin/sleep 2


# Start Postfix MTA
if /usr/sbin/postfix -c /etc/mailer start &> /dev/null
then echo OK
else echo FAIL
fi


# Hold script run
exec /bin/sleep inf
