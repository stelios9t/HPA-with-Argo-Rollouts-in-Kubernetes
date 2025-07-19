# HPA

## Goal

Validate Kubernetes HPA functionality by triggering CPU-based scaling events and observing automatic pod adjustments.

## Setup

- Pod named cpu-app deployed as kind Argo Rollout
- HPA Resource targets Rollout/cpu-app with CPU threshold set to 30%
- Min pods 1, Max pods 5
- Once threshold is exceeded, HPA deploys new replicas to balance load
- Once five minutes pass where CPU is down then HPA initiates replica decrease. Five minutes are set to avoid rapid up/down scaling due to brief dips

## Configuration Snippet

```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: cpu-app-hpa
spec:
  scaleTargetRef:
    apiVersion: argoproj.io/v1alpha1
    kind: Rollout
    name: cpu-app
  minReplicas: 1
  maxReplicas: 5
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 30
```

See HPA manifest [here](../kubernetes/hpa.yaml)

## Outcome

- System responds to real-time CPU pressure
