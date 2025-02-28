#!/bin/sh

# Khởi chạy ngrok
/usr/local/bin/ngrok http 5678 --log=stdout --region=auto &

# Khởi chạy n8n
/app/node_modules/.bin/n8n start --tunnel
