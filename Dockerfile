FROM python:3.9-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first
COPY actions/requirements-actions.txt ./

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements-actions.txt

# Copy actions code
COPY actions/ ./

EXPOSE 5055

# Start the action server
CMD ["python", "-m", "rasa_sdk", "start", "--actions", "actions", "--port", "5055"]