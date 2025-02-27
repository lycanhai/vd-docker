# Sử dụng image Debian-based thay vì Alpine
FROM n8nio/n8n:latest-debian

# Chạy với quyền root
USER root

# Cập nhật hệ thống và cài đặt Python, pip, wget, unzip
RUN apt-get update && apt-get install -y python3 python3-pip wget unzip

# Cài đặt ngrok
RUN wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip && \
    unzip ngrok-stable-linux-amd64.zip && \
    mv ngrok /usr/local/bin/ && \
    rm ngrok-stable-linux-amd64.zip

# Cài đặt DeepSeek Coder
RUN pip3 install --upgrade pip  # Cập nhật pip
RUN pip3 install torch transformers deepseek-coder

# Thiết lập biến môi trường cho n8n
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678
ENV NGROK_AUTH_TOKEN=<2tcmpcGEf3WT7ZdBWGstzYydSnc_2Y9nHhvbfDHRYaNKSsrMG>

# Sử dụng Bash để chạy nhiều lệnh liên tiếp
CMD ["/bin/bash", "-c", "ngrok authtoken $NGROK_AUTH_TOKEN && ngrok http 5678 --log=stdout & n8n"]
