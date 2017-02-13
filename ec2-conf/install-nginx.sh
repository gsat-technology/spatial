#!/bin/bash

FQDN=$1
EMAIL$2

apt-get install -y nginx
service nginx start
apt-get install -y letsencrypt

#unattended params
cat >/cli.ini <<EOF
  email=$EMAIL
  agree-tos=True
  text=True
EOF

letsencrypt certonly --config /cli.ini -a webroot --webroot-path=/var/www/html -d $FQDN

#replace default host config with pre-configured file and dynamically configure server_name
sed -e s/{SERVER_NAME}/$FQDN/g ./spatial/ec2-conf/default > /etc/nginx/sites-enabled/default