# Argo Rollout Strategy and Canary Deployment

## Goal

- Showcase controlled deployments using Argo Rollouts, enabling safe canary deployments without downtime.
- Integrate rollback mechanism.

## Setup

- Deployment Type: Rollout (Argo resource)
- Target App: cpu-app
- Update Strategy: Canary
- Canary Steps:
  - Set weight to 50%
  - Pause for 20 seconds

## Configuration Snippet

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Rollout
metadata:
  name: cpu-app
spec:
  replicas: 1
  strategy:
    canary:
      steps:
        - setWeight: 50
        - pause: { duration: 20 }
  selector:
    matchLabels:
      app: cpu-app
  template:
    metadata:
      labels:
        app: cpu-app
    spec:
      containers:
        - name: cpu-app
          image: k8s.gcr.io/hpa-example
          ports:
            - containerPort: 80
          resources:
            requests:
              cpu: 100m
            limits:
              cpu: 500m
```

See Argo Rollout manifest [here](../kubernetes/rollout.yaml)

# Outcome

- Canary update reached 50% traffic
- Automatic pause held rollout at intermediate stage for 20 seconds
- Final promotion completed the update
- Rollback option to previous image using the same logic
- Visual progress tracked using CLI and Argo UI
