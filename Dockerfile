FROM eclipse-temurin:11-jre

USER root

WORKDIR /deployments

COPY opentelemetry-javaagent-2.16.0.jar /opt/opentelemetry-javaagent.jar

ENV JAVA_TOOL_OPTIONS=-javaagent:/opt/opentelemetry-javaagent.jar \
    OTEL_JAVAAGENT_ENABLED=false \
    OTEL_EXPORTER_OTLP_ENDPOINT=http://alloy:4318 \
    OTEL_RESOURCE_ATTRIBUTES=service.name=sb2-smoketest,service.namespace=sb2-smoketest-ns,service.instance.id=sb2-smoketest-cnt,service.version=1.0.0

COPY target/*.jar app.jar

USER 1000

EXPOSE 8080 8081

ENTRYPOINT ["java","-jar","app.jar"]