FROM alpine:edge

RUN apk add --no-cache \
    clamav \ 
	rsyslog \
	clamav-libunrar

RUN mkdir /var/run/clamav && \
    chown clamav:clamav /var/run/clamav && \
    chmod 750 /var/run/clamav 

USER clamav

RUN ["/usr/bin/freshclam"] # Pull definitions
RUN ["/usr/bin/freshclam", "-d", "-c", "3"] # Refresh every 3 hours
RUN ["/usr/sbin/clamd"] # Start daemon