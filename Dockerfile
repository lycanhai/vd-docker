# Dùng image có Python 3.9 sẵn
FROM python:3.9-slim

# Cài đặt các công cụ cần thiết
RUN apt-get update && apt-get install -y wget unzip curl && rm -rf /var/lib/apt/lists/*

# Cài đặt ngrok
RUN wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip && \
    unzip ngrok-stable-linux-amd64.zip && \
    mv ngrok /usr/local/bin/ && \
    rm ngrok-stable-linux-amd64.zip

# Cài đặt n8n
RUN pip install --no-cache-dir n8n

# Cài đặt DeepSeek Coder và các thư viện liên quan
RUN pip install --no-cache-dir torch transformers deepseek-coder

# Thiết lập biến môi trường
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678
ENV NGROK_AUTH_TOKEN=<2tcmpcGEf3WT7ZdBWGstzYydSnc_2Y9nHhvbfDHRYaNKSsrMG>

# Chạy n8n và ngrok
CMD ["/bin/bash", "-c", "ngrok authtoken $NGROK_AUTH_TOKEN && ngrok http 5678 --log=stdout & n8n"]
