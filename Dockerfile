FROM python:3.13-slim

# Install system dependencies required for voice
RUN apt-get update && apt-get install -y \
    ffmpeg \
    libopus0 \
    libsodium23 \
    libffi-dev \
    python3-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .

# Use the system libsodium for PyNaCl to avoid silent audio
ENV SODIUM_INSTALL=system

# Install Python dependencies (your requirements.txt stays untouched)
RUN pip install --no-cache-dir -r requirements.txt

CMD ["python", "new-auth.py"]
