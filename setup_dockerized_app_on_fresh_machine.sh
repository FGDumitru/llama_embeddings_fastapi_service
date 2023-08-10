#!/bin/bash

echo "Updating system packages..."
sudo apt-get update
echo "Installing Docker..."
sudo apt-get install docker.io
echo "Starting Docker service..."
sudo systemctl start docker
echo "Checking Docker version..."
sudo docker --version
echo "Adding current user to the Docker group..."
sudo usermod -aG docker $USER
echo "Removing old embeddings directory..."
rm -rf embeddings
echo "Cloning the embeddings repository..."
git clone git@github.com:FGDumitru/llama_embeddings_fastapi_service.git embeddings

# Change to the repository directory
cd embeddings

git checkout phpllm


# Build the Docker image
echo "Building the Docker image..."
sudo docker build -t phpllm-embeddings .

# Run the Docker container
echo "Running the Docker container..."
sudo docker run -e TERM=$TERM -p 8089:8089 phpllm-embeddings

echo "Script completed!"
