FROM python:3.9-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements
COPY requirements.txt ./

# Install packages
RUN pip install --no-cache-dir -r requirements.txt

# Copy all files
COPY . .

# Train the model
RUN rasa train

EXPOSE 5005

# Start Rasa
CMD ["rasa", "run", "--enable-api", "--cors", "*", "--port", "5005"]