FROM rasa/rasa:3.6.16

WORKDIR /app

# Copy project files
COPY . /app

# Install action server dependencies (if needed)
RUN pip install -r requirements.txt

# Train model (optional — or do this locally and commit models/)
RUN rasa train

# Expose port
EXPOSE 5005

# Run Rasa server
CMD ["run", "--enable-api", "--port", "5005", "--cors", "*"]
