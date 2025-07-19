# Automated Rollback with Analysis Template

## Objective

Demonstrate automated rollback of a canary deployment using Argo Rollouts based on real-time Prometheus metrics.

## Feature

AnalysisTemplate is an ArgoRollout feature that allows automatic rollback if metrics (e.g., HTTP errors) breach a defined threshold.

## Metrics Logic

```promql
sum(rate(http_requests_total{status=~"5.."}[30s])) > 0
```

> Checks for 5xx errors. If any are detected in 3 consecutive intervals (10s each), rollback is triggered.

## Simulation

- Deploy a new image that exposes two endpoints: / and /error, with the latter returning 500 responses/

```bash
argo rollouts set image cpu-app cpu-app=argoproj/rollouts-demo:blue
```

- Generate error load during canary deployment stage by hitting the /error path. Use the Cluster IP of the pod's service.

```bash
while true; do wget -q -O- http://<Cluster-Ip-Service>/cpu; done
```

- Argo Rollouts detects failure threshold via AnalysisTemplate and automatically rollsback to previous stable image
