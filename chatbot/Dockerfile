# base image
FROM python:3.10

# Set the working directory
WORKDIR /app/

# Update os package and install necessary pakcage
RUN apt-get update && apt-get install -y \
    curl \
    && apt-get clean

# Copy the application code
COPY . .

# set the Python environment path
ENV PYTHONPATH=/app

# install python package
RUN pip install -r requirements.txt

# Download gguf file(stored in model parameters) from huggingface
RUN huggingface-cli download heegyu/EEVE-Korean-Instruct-10.8B-v1.0-GGUF ggml-model-Q5_K_M.gguf --local-dir ./EEVE-Korean-Instruct-10.8B-v1.0-GGUF --local-dir-use-symlinks False

# Install Ollama
RUN bash -c "$(curl -fsSL https://ollama.com/install.sh)"

# Start the ollama server in the background
RUN ollama serve & \
    # Wait for the ollama server to start (adjust time if necessary)
    sleep 10 && \
    # Create the model after the server is ready
    ollama create EEVE-Korean-10.8B -f ./EEVE-Korean-Instruct-10.8B-v1.0-GGUF/Modelfile

# Expose the port that the app will run on
EXPOSE 8001

CMD ["uvicorn", "app.main:app", "--reload", "--port", "8001"]

