# Dockerfile

# Use a specific, stable Python image
# Python 3.12 was used in the provided execution environment
FROM python:3.12-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY heart_classifier.py .

# Create a directory for the ML artifacts and model persistence
# This is where run_training will save the final_model.pkl and plots
RUN mkdir -p data

# The FastAPI application runs on port 8000
EXPOSE 8000

# Set the entrypoint for the application script
ENTRYPOINT ["python", "heart_classifier.py"]

# Default command: serves the API, but will fail if the model is not present.
# The user must first run the 'train' command to create 'data/final_model.pkl'.
# A better default for a production image would be to rely on a pre-trained model.
# We'll use a placeholder command here, expecting the user to provide the --mode argument.
CMD ["--mode", "serve", "--host", "0.0.0.0", "--port", "8000"]