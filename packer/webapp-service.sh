#!/bin/bash

sudo sh -c 'cat << EOF > /etc/systemd/system/webapp.service
[Unit]
Description=Node.js Application
After=network.target network-online.target
Wants=network-online.target

[Service]
Type=simple
User=csye6225
Group=csye6225
WorkingDirectory=/opt/webapp/
ExecStartPre=/bin/bash -c "while [ ! -f /opt/finish ]; do sleep 1; done"
ExecStart=/usr/bin/node /opt/webapp/index.js
Restart=on-failure
RestartSec=3
StandardOutput=append:/var/log/webapp_output.log
StandardError=append:/var/log/webapp_error.log

[Install]
WantedBy=multi-user.target
EOF'