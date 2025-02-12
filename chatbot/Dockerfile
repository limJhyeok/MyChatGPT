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

RUN if [ "$USE_GPU" = "true" ]; then \
      echo "Setting up GPU environment"; \
      # Download gguf file(stored in model parameters) from huggingface
      huggingface-cli download heegyu/EEVE-Korean-Instruct-10.8B-v1.0-GGUF ggml-model-Q5_K_M.gguf \
          --local-dir ./EEVE-Korean-Instruct-10.8B-v1.0-GGUF \
          --local-dir-use-symlinks False && \
    # Install Ollama
      bash -c "$(curl -fsSL https://ollama.com/install.sh)" && \
    # Start the ollama server in the background
      ollama serve & sleep 10 && \
    # Create the model after the server is ready
      ollama create EEVE-Korean-10.8B -f ./EEVE-Korean-Instruct-10.8B-v1.0-GGUF/Modelfile; \
    else \
      echo "Skipping GPU setup"; \
    fi

# Expose the port that the app will run on
EXPOSE 8001

CMD ["uvicorn", "app.main:app", "--host",  "0.0.0.0", "--reload", "--port", "8001"]
