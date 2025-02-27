# Sử dụng image chính thức của n8n
FROM n8nio/n8n:latest

# Cập nhật hệ thống và cài đặt ngrok
USER root
RUN apt-get update && apt-get install -y wget unzip && \
    wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip && \
    unzip ngrok-stable-linux-amd64.zip && \
    mv ngrok /usr/local/bin/ && \
    rm ngrok-stable-linux-amd64.zip

# Thiết lập môi trường
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678

# Chạy n8n và ngrok khi container khởi động
CMD (ngrok http 5678 --log=stdout &) && n8n
