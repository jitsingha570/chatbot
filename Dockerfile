FROM rasa/rasa:3.6.0-full

WORKDIR /app

# Copy requirements first for better caching
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy all project files
COPY . .

# Train the model
RUN rasa train

# Expose the port Render expects
EXPOSE 5005

# Health check
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:5005 || exit 1

# Start Rasa
CMD ["run", "--enable-api", "--cors", "*", "--debug", "--port", "5005"]