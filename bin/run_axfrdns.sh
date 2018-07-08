#!/bin/sh

cat >> /root/.ssh/config <<EOF
StrictHostKeyChecking no
EOF

if [ -r /root/.ssh/id_rsa ]; then
    chmod 0600 /root/.ssh/id_rsa
fi

if [ ! -d /etc/axfrdns/root/.git ]; then
    cd /
    rm -rf /etc/axfrdns/root/* /etc/axfrdns/root/.git
    git clone $GIT_DNSDATA /etc/axfrdns/root
fi

# Runs git pull && make in a while loop to avoid cron installation
/dnsdata_update.sh 2>&1 &

for i in `ls -1 /etc/axfrdns/env`
do
  eval $i=`cat /etc/axfrdns/env/$i`
  eval export $i
done

sleep 2

echo "Starting axfrdns"
cd /etc/axfrdns
/etc/axfrdns/run | /usr/local/bin/tai64n | /usr/local/bin/tai64nlocal 2>&1
echo "axfrdns stopped"
sleep 500
