FROM alpine:latest

# Install required apps
RUN apk add --no-cache bash rsync zip tzdata busybox-suid

# Copy only what's needed to run cron and start the admin container
COPY start-admin.sh /scripts/start-admin.sh
COPY crontab.txt /scripts/crontab.txt

WORKDIR /scripts

ENTRYPOINT ["/scripts/start-admin.sh"]

