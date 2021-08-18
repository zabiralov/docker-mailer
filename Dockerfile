
# Set base image
FROM alpine:3.14

# Maintainer
LABEL authors="Alexander Zabiralov <zabiralov@gmail.com>"

# Install packages
RUN apk --no-cache add --update dumb-init \
    man-db man-db-doc \
    netcat-openbsd netcat-openbsd-doc \
    postfix postfix-doc \
    opendkim opendkim-doc \
    cyrus-sasl cyrus-sasl-doc \
    cyrus-sasl-login cyrus-sasl-digestmd5

# Copy configuration files
COPY . /etc/

# Default entrypoint may be rewrite in compose file
ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["/etc/start.sh"]
