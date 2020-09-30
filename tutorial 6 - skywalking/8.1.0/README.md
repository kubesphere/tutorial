- Create `demo` namespace

```bash
kubectl create namespace demo
```

- Install skywalking

```bash
helm repo add elastic https://helm.elastic.co
helm dep up skywalking
helm install skywalking skywalking -n demo
```

- Install sample apps

```bash
kubectl apply -f apm-springcloud-demo
```

- Generate some traffics to the sample apps

```bash
# should be executed inside a pod
curl apm-eureka.demo.svc:8761/eureka/apps/APM-ITEM/apm-item-6fccf65776-dx4hv:apm-item:8082
curl apm-eureka.demo.svc:8761/eureka/apps/delta
curl apm-eureka.demo.svc:8761/eureka/apps/APM-ITEM
```