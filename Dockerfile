# Kiểm tra Python và pip trước khi cài đặt
RUN python --version && pip --version
RUN pip install deepseek-coder || true
# Sử dụng Python 3.9 đầy đủ thay vì slim (slim có thể thiếu nhiều công cụ)
FROM python:3.9

# Cài đặt các công cụ cần thiết
RUN apt-get update && apt-get install -y git wget unzip curl && rm -rf /var/lib/apt/lists/*

# Kiểm tra xem git có hoạt động không
RUN git --version

# Clone repo và cài đặt DeepSeek-Coder
RUN git clone https://github.com/DeepSeek-AI/DeepSeek-Coder.git /deepseek-coder && \
    cd /deepseek-coder && \
    pip install --no-cache-dir .

# Dùng image có Python 3.9 đầy đủ
FROM python:3.9

# Cài đặt công cụ cần thiết
RUN apt-get update && apt-get install -y git wget unzip curl && rm -rf /var/lib/apt/lists/*

# Cài đặt ngrok
RUN wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip && \
    unzip ngrok-stable-linux-amd64.zip && \
    mv ngrok /usr/local/bin/ && \
    rm ngrok-stable-linux-amd64.zip

# Cài đặt n8n
RUN pip install --no-cache-dir n8n torch transformers

# Cài đặt DeepSeek Coder từ source
RUN git clone https://github.com/DeepSeek-AI/DeepSeek-Coder.git /deepseek-coder && \
    cd /deepseek-coder && \
    pip install --no-cache-dir .

# Thiết lập biến môi trường
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678
ENV NGROK_AUTH_TOKEN=<2tcmpcGEf3WT7ZdBWGstzYydSnc_2Y9nHhvbfDHRYaNKSsrMG>

# Chạy n8n và ngrok
CMD ["/bin/bash", "-c", "ngrok authtoken $NGROK_AUTH_TOKEN && ngrok http 5678 --log=stdout & n8n"]
