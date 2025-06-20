# Spring boot 2 smoke test

```sh
mvn clean package && \
docker rmi alainpham/sb2-smoketest:1.0.1 ; \
docker build . -t alainpham/sb2-smoketest:1.0.1 && \
docker push alainpham/sb2-smoketest:1.0.1

docker run --rm --net primenet \
    -p 8080:8080 \
    -p 8081:8081 \
    -e OTEL_JAVAAGENT_ENABLED="true" \
    --name sb2-smoketest alainpham/sb2-smoketest

docker push alainpham/sb2-smoketest

curl http://localhost:8080/

```

Kube deploy

```sh
kubectl create ns apps
kubectl apply -n apps -f https://raw.githubusercontent.com/gpocs/sb2-smoketest/refs/heads/master/k8s-deployment.yaml
```