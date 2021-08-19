#!/usr/bin/env sh

echo -n "Start syslogd ... "
if /sbin/syslogd -s 0 -O -
then echo OK
else echo FAIL
fi


echo -n "Create mail aliases ... "
if /usr/sbin/postalias -c /etc/mailer lmdb:/etc/mailer/aliases
then echo OK
else echo FAIL
fi


echo -n "Create sasldb2 database ... "
if echo -n 'AHmOi2CCVtchGeG' | /usr/sbin/saslpasswd2 -f /etc/sasl2/sasldb2 -u "$DKIM_DOMAIN" -p "$RELAY_USER"
then echo OK
else echo FAIL
fi


echo -n "Change owner to postfix user for /etc/mailer ... "
if chown -R postfix:postfix /etc/mailer
then echo OK
else echo FAIL
fi


echo -n "Set permissions for $DKIM_KEYFILE ... "
if chmod 400 $DKIM_KEYFILE
then echo OK
else echo FAIL
fi


echo -n "Start OpenDKIM ... "
if /usr/sbin/opendkim -d "$DKIM_DOMAIN" -k "$DKIM_KEYFILE" -s "$DKIM_SELECTOR" -x /etc/mailer/opendkim.conf
then echo OK
else echo FAIL
fi


echo -n "Start Postfix MTA ... "
if /usr/sbin/postfix -c /etc/mailer start &> /dev/null
then echo OK
else echo FAIL
fi


exec /bin/sleep inf
