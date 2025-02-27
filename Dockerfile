# Sử dụng image chính thức của n8n
FROM n8nio/n8n:latest

# Chạy với quyền root để cài đặt gói cần thiết
USER root

# Cập nhật hệ thống và cài đặt wget, unzip
RUN apk update && apk add --no-cache wget unzip

# Tải và cài đặt ngrok
RUN wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip && \
    unzip ngrok-stable-linux-amd64.zip && \
    mv ngrok /usr/local/bin/ && \
    rm ngrok-stable-linux-amd64.zip

# Thiết lập biến môi trường cho n8n
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678

# Khởi động n8n và ngrok
CMD (ngrok http 5678 --log=stdout &) && n8n
