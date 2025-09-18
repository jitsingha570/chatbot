FROM rasa/rasa:3.6.0-full

WORKDIR /app

# Copy requirements first for better caching
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy all project files
COPY . .

# Train the model (skip validation to avoid database issues)
RUN rasa train --skip-validation

# Expose the port
EXPOSE 5005

# Start Rasa
CMD ["run", "--enable-api", "--cors", "*", "--port", "5005"]