FROM rasa/rasa:3.6.18-full

# Copy project files
COPY . /app
WORKDIR /app

# Train model
RUN rasa train

# Expose Rasa server port
EXPOSE 5005

# Run rasa server with API enabled
CMD ["run", "--enable-api", "--cors", "*", "--port", "5005"]
