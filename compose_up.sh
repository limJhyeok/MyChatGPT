#!/bin/bash

# Check for GPU availability using nvidia-smi
if nvidia-smi > /dev/null 2>&1; then
    echo "GPU detected"
    docker-compose -f docker-compose.gpu.yaml up --build
else
    echo "No GPU detected"
    docker-compose -f docker-compose.cpu.yaml up --build
fi
