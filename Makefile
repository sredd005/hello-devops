.PHONY: build deploy dev clean

# Build the Docker image with timestamp tag
build:
	$(eval TAG := $(shell date +%s))
	eval $$(minikube docker-env) && docker build -t saireddy023/hello-devops-sf:$(TAG) .
	@echo "Built image with tag: $(TAG)"

# Deploy to Kubernetes
deploy:
	kubectl create namespace hello --dry-run=client -o yaml | kubectl apply -f -
	kubectl apply -f k8s/
	kubectl wait --for=condition=available --timeout=300s deployment/hello-devops-sf -n hello

# Full development workflow: build with unique tag, update deployment, and port-forward
dev:
	$(eval TAG := $(shell date +%s))
	eval $$(minikube docker-env) && docker build -t saireddy023/hello-devops-sf:$(TAG) .
	kubectl create namespace hello --dry-run=client -o yaml | kubectl apply -f -
	kubectl apply -f k8s/
	kubectl set image deployment/hello-devops-sf web=saireddy023/hello-devops-sf:$(TAG) -n hello
	kubectl wait --for=condition=available --timeout=300s deployment/hello-devops-sf -n hello
	@echo "🌐 Application available at http://localhost:8080"
	@echo "Press Ctrl+C to stop port forwarding"
	kubectl port-forward -n hello svc/hello-svc 8080:5000

# Clean up resources
clean:
	kubectl delete namespace hello --ignore-not-found=true

# Show application status
status:
	kubectl get pods,svc -n hello