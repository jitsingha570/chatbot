FROM rasa/rasa-sdk:3.6.0

WORKDIR /app

# Copy actions code
COPY actions/requirements-actions.txt ./
RUN pip install --no-cache-dir -r requirements-actions.txt

COPY actions/ ./

EXPOSE 5055

CMD ["start", "--actions", "actions", "--port", "5055"]