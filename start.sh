#!/bin/sh

# Khởi chạy ngrok
./ngrok http 5678 --log=stdout --region=auto &

# Khởi chạy n8n
n8n start --tunnel
