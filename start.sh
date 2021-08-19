#!/usr/bin/env sh


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


exec /usr/sbin/postfix -c /etc/mailer start-fg


# exec /bin/sleep inf
