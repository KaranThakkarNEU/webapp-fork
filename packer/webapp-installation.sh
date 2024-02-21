#!/bin/bash

cd /
unzip tmp/packer/webapp.zip -d /home/packer/webapp/
cd home/packer/webapp/
npm install
touch .env
echo "MYSQL_HOSTNAME=localhost" >>.env
echo "MYSQL_PASSWORD=Karan@mysql001" >>.env
echo "MYSQL_DATABASENAME=cloud_assignment02" >>.env
echo "MYSQL_USERNAME=root" >>.env
echo "SALT_ROUNDS=10" >>.env
echo "PORT=8888" >>.env