# Architecture

This portfolio starter has two deployment paths:

1. **Local learning path:** Python Flask API -> Docker image -> kind Kubernetes cluster -> Deployment, Service, probes, resource requests/limits, and HPA.
2. **Cloud infrastructure path:** Terraform -> existing AWS VPC/private subnets -> Amazon EKS managed node group.

GitHub Actions runs Python tests and builds the container image on pushes and pull requests to `main`.

## Request flow

A client reaches the Kubernetes Service on port 80. The Service forwards traffic to the API container on port 8080. Kubernetes readiness and liveness probes call `/ready` and `/health`.

## Scope and limitations

The Terraform configuration expects a pre-existing VPC and private subnets; it does not create networking. The EKS module configuration is a starter and should be reviewed against current AWS and Kubernetes version support before use. Public API endpoint access is enabled for demo convenience; harden access controls for real environments. This project has not been deployed or load-tested as part of repository initialization.
