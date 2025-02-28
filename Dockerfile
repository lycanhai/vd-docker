# Sử dụng base image node:18
FROM node:18-alpine

# Cài đặt các dependencies cần thiết
RUN apk add --no-cache openssh-client

# Tạo thư mục làm việc
WORKDIR /app

# Copy package.json và package-lock.json
COPY package*.json ./

# Cài đặt dependencies
RUN npm install

# Copy source code
COPY . .

# Cấp quyền thực thi cho start.sh
RUN chmod +x start.sh

# Cài đặt ngrok
RUN wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.tgz \
    && tar -xzf ngrok-stable-linux-amd64.tgz \
    && mv ngrok /usr/local/bin/

# Expose port 5678 (n8n)
EXPOSE 5678

RUN ls -l /app/

# Command chạy n8n và ngrok
CMD ["sh", "start.sh"]
###
FROM python:3.9-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN pip install --no-cache-dir deepseek-ai

# Copy source code (bao gồm run_deepseek.py)
COPY . .

# Cấp quyền thực thi nếu cần
# RUN chmod +x run_deepseek.py

CMD ["python", "run_deepseek.py"]
