#!/bin/bash

# this file is being executed in /opt/codedeploy-agent/deployment-root/47../<deployment_id>/

#stdout logs of this process executing can be found in /opt/codedeploy-agent/deployment-root/47../<deployment_id>/logs/scripts.log

# here we update the server and install node and npm
echo installing dependencies
sudo yum update
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo yum install nodejs -y
sudo yum -y install npm

# check to make sure the symbolic link for nodejs node exists
echo checking for nodejs symlink
file="/usr/bin/node"
if [ -f $file ] && [ ! -L $file ] ; then
  echo "$file exists and is not a symlink"
  sudo ln -s /usr/bin/nodejs
else
  echo "$file exists and is already a symlink"
fi

# install the application using npm
# we need to traverse to where the application bundle is copied too.
echo installing application with npm
# deleting old files
sudo rm -r /var/www/html/*

cd /var/www/one/
sudo npm install

echo installing pm2
sudo npm install pm2 -g
