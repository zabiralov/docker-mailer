# docker-mailer #

#### DESCRIPTION ####
Alpine-based image with Postfix and OpenDKIM


#### BUILD AND RUN ####
Run `make build` for create actual image (minimal)

Run `make buildf` for create actual image (with doc packages installed)

Run `make up` for start via docker-compose

Run `make down` for stop

#### ENVIRONMENT ####
```
    DKIM_DOMAIN: example.com
    DKIM_KEYFILE: /etc/mailer/default.private
    DKIM_SELECTOR: default
    RELAY_USER: relay
    RELAY_PASS: securepass
```
