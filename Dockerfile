FROM python:3.13-slim

# Install system dependencies required for voice + git (for pip to clone discord.py-self)
RUN apt-get update && apt-get install -y \
    git \
    ffmpeg \
    libopus0 \
    libsodium23 \
    libffi-dev \
    python3-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .

# Use system libsodium for PyNaCl (avoids silent voice on some Railway builds)
ENV SODIUM_INSTALL=system

RUN pip install --no-cache-dir -r requirements.txt

CMD ["python", "new-auth.py"]
