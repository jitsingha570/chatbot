FROM python:3.9-slim

WORKDIR /app

# Install dependencies
RUN pip install --no-cache-dir rasa-sdk==3.6.0 twilio==8.0.0

# Copy actions code
COPY actions/ ./

EXPOSE 5055

# Start action server - FIXED COMMAND
CMD ["python", "-m", "rasa_sdk", "start", "--actions", "actions", "--port", "5055"]