# Monitoring

## Objective

Enable resource monitoring to visualize HPA-driven behavior across pods and deployments.

## Tools

- Prometheus: Collects metrics from the Kubernetes cluster
- Grafana: Visualizes resource usage metrics
- Metrics-server: Required by HPA to gather CPU/Memory data

## Custom Grafana Dashboard

- CPU Usage per Replica

```promql
sum by (pod) (rate(container_cpu_usage_seconds_total{namespace="default", pod=~"cpu-app.*", container!="POD"}[1m]))
```

> Shows CPU usage over time for each replica

- Total CPU Usage

```promql
sum by (pod) (rate(container_cpu_usage_seconds_total{namespace="default", pod=~"cpu-app.*", container!="POD"}[1m]))
```

> Overall CPU usage by all HPA pods

- Replica History

```promql
count(kube_pod_status_phase{namespace="default", phase="Running", pod=~"cpu-app.*"})
```

> Shows how many replicas were active over time

- Total Memory Usage

```promql
sum(container_memory_usage_bytes{namespace="default", pod=~"cpu-app.*"})
```

> Overall Memory by all HPA pods

- Replica Count

```promql
count(kube_pod_status_phase{namespace="default", phase="Running", pod=~"cpu-app.*"})
```

> Shows how the number of running cpu-app replicas changes in response to CPU pressure.
