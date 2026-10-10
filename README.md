# Kubernetes Platform Automation

A hands-on portfolio project demonstrating cloud-native application delivery, Kubernetes operations, infrastructure-as-code patterns, and CI automation.

## What this project demonstrates

- Containerizing a small Python Flask health API with Docker
- Deploying the app to Kubernetes with Deployment, Service, probes, resource controls, and HorizontalPodAutoscaler manifests
- Validating application behavior with pytest
- Running automated tests and Docker build checks with GitHub Actions
- Providing an AWS EKS Terraform starter configuration for review and extension

> **Status:** Portfolio starter. The local Kubernetes deployment and AWS infrastructure have not been verified by this repository commit. Do not claim production deployment until you run and document it yourself.

## Repository layout

```text
app/                     Flask application and Dockerfile
kubernetes/              Kubernetes namespace, deployment, service, HPA
terraform/eks/            AWS EKS Terraform starter
tests/                   Unit tests
.github/workflows/        CI workflow
docs/                    Architecture and troubleshooting notes
```

## Run locally

Requirements: Python 3.11+, Docker, kubectl, and optionally kind and Terraform.

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r app/requirements.txt
python app/app.py
```

In another terminal:

```bash
curl http://127.0.0.1:8080/health
```

Run tests:

```bash
pip install -r app/requirements.txt
pytest -q
```

## Build the container

```bash
docker build -t platform-health-api:local -f app/Dockerfile .
docker run --rm -p 8080:8080 platform-health-api:local
```

## Deploy to local Kubernetes with kind

```bash
kind create cluster --name platform-demo
docker build -t platform-health-api:local -f app/Dockerfile .
kind load docker-image platform-health-api:local --name platform-demo
kubectl apply -f kubernetes/namespace.yaml
kubectl apply -f kubernetes/deployment.yaml -f kubernetes/service.yaml -f kubernetes/hpa.yaml
kubectl -n platform-demo rollout status deployment/platform-health-api
kubectl -n platform-demo port-forward service/platform-health-api 8080:80
```

Then check `http://127.0.0.1:8080/health`. The HPA needs Metrics Server to report metrics; it may remain without metrics on a bare kind cluster until Metrics Server is installed.

## Terraform

Review `terraform/eks/` before use. The configuration expects an existing VPC and private subnets. EKS can incur AWS charges. Configure credentials, inspect the plan, and explicitly approve any `terraform apply`. Never commit credentials, state files, or secret values.

## Evidence and screenshots

Add your own screenshots to `docs/screenshots/` after successfully running the commands. Suggested evidence: passing pytest output, Docker image build, `kubectl get pods,svc,hpa -n platform-demo`, rollout status, and a GitHub Actions run. Do not add screenshots that imply tests passed unless you actually ran them.

## Next improvements

- Add Terraform formatting and validation to CI
- Add image publishing to GHCR using repository secrets
- Add Prometheus/Grafana dashboards and service-level indicators
- Add policy checks and deployment security scanning
- Add a runbook for pod crash loops, resource pressure, and failed rollouts
