
# Set base image
FROM alpine:3.14

# Maintainer
LABEL authors="Alexander Zabiralov <zabiralov@gmail.com>"

# Install packages
RUN apk --no-cache add --update postfix opendkim dumb-init

# Copy configuration files
COPY . /etc/

# Default entrypoint may be rewrite in compose file
ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["/etc/start.sh"]
