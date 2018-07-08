#!/bin/sh

cd /
while /bin/true
do
  #date
  # Ignore DEPRECATED due to docker gogs image that needs updating
  cd /etc/axfrdns/root && git pull 2>&1 | egrep -ve "(is up to date.|Already up to date.|DEPRECATED)"
  make data.cdb 2>&1 | egrep -ve "(is up to date.|Already up to date.|DEPRECATED)"
  make tcp.cdb 2>&1 | egrep -ve "(is up to date.|Already up to date.|DEPRECATED)"
  sleep $GIT_UPDATE_FREQUENCY
done
