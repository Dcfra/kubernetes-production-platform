# Troubleshooting runbook

## Pod is not starting

```bash
kubectl get pods -n platform-demo
kubectl describe pod <pod-name> -n platform-demo
kubectl logs <pod-name> -n platform-demo --previous
```

Check image name, image availability, startup errors, probes, and resource limits.

## Deployment rollout is stuck

```bash
kubectl rollout status deployment/platform-health-api -n platform-demo
kubectl rollout history deployment/platform-health-api -n platform-demo
kubectl describe deployment platform-health-api -n platform-demo
kubectl get events -n platform-demo --sort-by=.lastTimestamp
```

## Service does not respond

```bash
kubectl get svc,endpoints -n platform-demo
kubectl port-forward service/platform-health-api 8080:80 -n platform-demo
curl -i http://127.0.0.1:8080/health
```

Confirm the Service selector matches pod labels and the container listens on port 8080.

## HPA shows unknown metrics

```bash
kubectl get hpa -n platform-demo
kubectl top pods -n platform-demo
```

The cluster needs a working Metrics Server. Local kind clusters may not have it installed by default.
