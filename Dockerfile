FROM python:3.13-slim

# Install system dependencies for voice, davey (Rust), and git (for pip)
RUN apt-get update && apt-get install -y \
    git \
    rustc \
    cargo \
    ffmpeg \
    libopus0 \
    libsodium23 \
    libffi-dev \
    python3-dev \
    build-essential \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .

# Force PyNaCl to use the system libsodium (avoids silent voice)
ENV SODIUM_INSTALL=system

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Start the bot
CMD ["python", "new-auth.py"]
