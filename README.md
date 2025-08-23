# hello-devops
i like devops 

## Quick Start

### Development Workflow
```bash
# Build, deploy, and start port forwarding in one command
make dev
```

### Individual Commands
```bash
# Build Docker image
make build

# Deploy to Kubernetes
make deploy

# Check application status
make status

# Clean up resources
make clean
```

### Manual Deployment
```bash
# Run the deployment script
./deploy.sh
```

## Access Application
After running `make dev` or `./deploy.sh`, the application will be available at:
- http://localhost:8080

## Architecture
- **Flask Application**: Simple web server with health check
- **Docker**: Containerized application
- **Kubernetes**: Deployed on minikube
- **CI/CD**: GitHub Actions for automated builds