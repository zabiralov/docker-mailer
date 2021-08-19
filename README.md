# docker-mailer #

#### DESCRIPTION ####
Alpine-based image with Postfix and OpenDKIM


#### BUILD AND RUN ####
Run `make build` for create actual image.

Run `make up` for start via docker-compose


#### ENVIRONMENT ####
```
    DKIM_DOMAIN: example.com
    DKIM_KEYFILE: /etc/mailer/default.private
    DKIM_SELECTOR: default
    RELAY_USER: relay
    RELAY_PASS: securepass
```
