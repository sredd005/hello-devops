#!/bin/bash

# Deploy script for hello-devops application
set -e

echo "🚀 Starting deployment..."

# Check if minikube is running
if ! minikube status > /dev/null 2>&1; then
    echo "Starting minikube..."
    minikube start
fi

# Set docker environment to use minikube's docker daemon
eval $(minikube docker-env)

# Build the image locally
echo "Building Docker image..."
docker build -t saireddy023/hello-devops-sf:latest .

# Create namespace if it doesn't exist
kubectl create namespace hello --dry-run=client -o yaml | kubectl apply -f -

# Apply Kubernetes manifests
echo "Deploying to Kubernetes..."
kubectl apply -f k8s/

# Wait for deployment to be ready
echo "Waiting for deployment to be ready..."
kubectl wait --for=condition=available --timeout=300s deployment/hello-devops-sf -n hello

# Get pod status
kubectl get pods -n hello

echo "✅ Deployment complete!"
echo "🌐 Starting port forwarding on http://localhost:8080"
echo "Press Ctrl+C to stop port forwarding"

# Start port forwarding (this will run in foreground)
kubectl port-forward -n hello svc/hello-svc 8080:5000