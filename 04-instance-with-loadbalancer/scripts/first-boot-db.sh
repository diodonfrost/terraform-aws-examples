#!/bin/bash

echo "hello world"

apt update
apt install mariadb-server -y
systemctl start mysql
systemctl enable mysql
