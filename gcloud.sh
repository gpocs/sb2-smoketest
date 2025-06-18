helm repo add grafana https://grafana.github.io/helm-charts &&
  helm repo update &&
  helm upgrade --install --atomic --timeout 300s grafana-k8s-monitoring grafana/k8s-monitoring \
    --namespace "default" --create-namespace --values - <<'EOF'
cluster:
  name: 
destinations:
  - name: grafana-cloud-metrics
    type: prometheus
    url: https://prometheus-prod-24-prod-eu-west-2.grafana.net./api/prom/push
    auth:
      type: basic
      username: "xx"
      password: xxx=
  - name: grafana-cloud-logs
    type: loki
    url: https://logs-prod-012.grafana.net./loki/api/v1/push
    auth:
      type: basic
      username: "xx"
      password: xxx=
  - name: grafana-cloud-otlp-endpoint
    type: otlp
    url: https://otlp-gateway-prod-eu-west-2.grafana.net./otlp
    protocol: http
    auth:
      type: basic
      username: "xx"
      password: xxx=
    metrics:
      enabled: true
    logs:
      enabled: true
    traces:
      enabled: true
  - name: grafana-cloud-profiles
    type: pyroscope
    url: https://profiles-prod-002.grafana.net.:443
    auth:
      type: basic
      username: "xx"
      password: xxx=
clusterMetrics:
  enabled: true
annotationAutodiscovery:
  enabled: true
clusterEvents:
  enabled: true
podLogs:
  enabled: true
applicationObservability:
  enabled: true
  receivers:
    otlp:
      grpc:
        enabled: true
        port: 4317
      http:
        enabled: true
        port: 4318
    zipkin:
      enabled: true
      port: 9411
  connectors:
    grafanaCloudMetrics:
      enabled: true
profiling:
  enabled: true
  ebpf:
    enabled: false
  java:
    enabled: true
    annotationSelectors:
      profiles.grafana.com/inject-java: "true"
    extraDiscoveryRules: |
      rule {
        source_labels = ["__meta_kubernetes_pod_annotation_resource_opentelemetry_io_service_name"]
        regex = "(.+)"
        target_label = "service_name"
      }
    
      rule {
        action="replace"    
        regex = "(.+)"
        source_labels = ["__meta_kubernetes_pod_annotation_resource_opentelemetry_io_service_namespace"]
        target_label = "namespace"
      }
  pprof:
    enabled: false
integrations:
  alloy:
    instances:
      - name: alloy
        labelSelectors:
          app.kubernetes.io/name:
            - alloy-metrics
            - alloy-singleton
            - alloy-logs
            - alloy-receiver
            - alloy-profiles
alloy-metrics:
  enabled: true
alloy-singleton:
  enabled: true
alloy-logs:
  enabled: true
alloy-receiver:
  enabled: true
  alloy:
    extraPorts:
      - name: otlp-grpc
        port: 4317
        targetPort: 4317
        protocol: TCP
      - name: otlp-http
        port: 4318
        targetPort: 4318
        protocol: TCP
      - name: zipkin
        port: 9411
        targetPort: 9411
        protocol: TCP
alloy-profiles:
  enabled: true
EOF
