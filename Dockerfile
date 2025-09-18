FROM rasa/rasa:3.6.16

# Switch to root to install dependencies
USER root

WORKDIR /app

# Copy project files
COPY . /app

# Upgrade pip and install action server dependencies
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Optional: Train model inside container (usually better to do locally and commit models/)
# RUN rasa train

# Switch back to default non-root user
USER 1001

# Expose port
EXPOSE 5005

# Run Rasa server
CMD ["rasa", "run", "--enable-api", "--port", "5005", "--cors", "*", "--debug"]
