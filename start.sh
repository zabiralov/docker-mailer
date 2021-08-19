#!/usr/bin/env sh


echo -n "Create mail aliases ... "
if /usr/sbin/postalias -c /etc/mailer lmdb:/etc/mailer/aliases
then echo OK
else exit 1
fi


echo -n "Create sasldb2 database ... "
if echo -n 'AHmOi2CCVtchGeG' | /usr/sbin/saslpasswd2 -f /etc/sasl2/sasldb2 -u "$DKIM_DOMAIN" -p "$RELAY_USER"
then echo OK
else exit 1
fi


echo -n "Set postfix owner for sasldb2 database ... "
if chown postfix /etc/sasl2/sasldb2
then echo OK
else exit 1
fi


echo -n "Set permissions for $DKIM_KEYFILE ... "
if chmod 400 $DKIM_KEYFILE
then echo OK
else exit 1
fi


echo -n "Start OpenDKIM ... "
if /usr/sbin/opendkim -d "$DKIM_DOMAIN" -k "$DKIM_KEYFILE" -s "$DKIM_SELECTOR" -x /etc/mailer/opendkim.conf
then echo OK
else exit 1
fi

exec /usr/sbin/postfix -c /etc/mailer start-fg
