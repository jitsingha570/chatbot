FROM ubuntu:22.04

WORKDIR /app

# Install Python and dependencies
RUN apt-get update && apt-get install -y \
    python3.9 \
    python3-pip \
    python3-venv \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements
COPY requirements.txt ./

# Install packages
RUN pip3 install --no-cache-dir -r requirements.txt

# Copy all files
COPY . .

# Train the model
RUN rasa train

EXPOSE 5005

# Start Rasa
CMD ["rasa", "run", "--enable-api", "--cors", "*", "--port", "5005"]