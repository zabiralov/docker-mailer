
# Set base image
FROM alpine:3.14

# Maintainer
LABEL authors="Alexander Zabiralov <zabiralov@gmail.com>"

# Install packages
RUN apk --no-cache add --update \
		bash curl postfix opendkim opendmarc dumb-init bind-tools

# Copy configuration files
COPY ./mailerconf/ /etc/

RUN ls -l /etc

# Rewrite default configuration to custom from mailerconf
RUN rm -f \
		/etc/postfix/main.cf \
		/etc/postfix/master.cf \
		/etc/opendkim/opendkim.conf	\
		/etc/opendmarc/opendmarc.conf	&& \
		ln /etc/mailerconf/postfix/main.cf /etc/postfix/main.cf && \
		ln /etc/mailerconf/postfix/master.cf /etc/postfix/master.cf && \
		ln /etc/mailerconf/opendkim/opendkim.conf /etc/opendkim/opendkim.conf && \
		ln /etc/mailerconf/opendmarc/opendmarc.conf /etc/opendmarc/opendmarc.conf && \
		ln /etc/mailerconf/profile.d/mailerconf.sh /etc/profile.d/mailerconf.sh

ENTRYPOINT ["/bin/sleep", "infinity"]
