FROM rasa/rasa:3.6.0-full

WORKDIR /app

# Copy requirements
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Install Twilio
RUN pip install --no-cache-dir twilio==8.0.0

# Copy all files
COPY . .

# Train the model
RUN rasa train

EXPOSE 5005

# Start Rasa with actions included
CMD ["run", "--enable-api", "--cors", "*", "--port", "5005"]