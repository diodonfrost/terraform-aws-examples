#!/bin/bash

echo "hello world"

apt update
apt install apache2 -y
systemctl start apache2
systemctl enable apache2
