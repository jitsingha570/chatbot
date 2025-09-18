FROM rasa/rasa:3.6.0-full

WORKDIR /app

# Copy requirements first
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy all project files except endpoints.yml
COPY credentials.yml ./
COPY config.yml ./
COPY domain.yml ./
COPY data/ ./data/
COPY actions/ ./actions/  # if you have custom actions

# Create an empty endpoints file for training
RUN echo "# Empty endpoints for training" > endpoints.yml

# Train the model
RUN rasa train

# Now copy the actual endpoints file (if you want to use it at runtime)
# COPY endpoints.production.yml ./endpoints.yml

EXPOSE 5005

CMD ["run", "--enable-api", "--cors", "*", "--port", "5005"]