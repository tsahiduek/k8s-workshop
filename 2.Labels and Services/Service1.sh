kubectl run backend-prod \
--image=gcr.io/kuar-demo/kuard-amd64:1 \
--replicas=3 \
--port=8080 \
--labels="ver=1,app=backend,env=prod"

kubectl expose deployment backend-prod

kubectl run cyberschool-prod \
--image=gcr.io/kuar-demo/kuard-amd64:2 \
--replicas=2 \
--port=8080 \
--labels="ver=2,app=cyberschool,env=prod"

kubectl expose deployment cyberschool-prod

kubectl get services -o wide

ALPACA_POD=$(kubectl get pods -l app=backend \
-o jsonpath='{.items[0].metadata.name}')

kubectl port-forward $ALPACA_POD 48858:8080

show DSN

KUBE_EDITOR="nano" kubectl edit deployment/backend-prod

        readinessProbe:
          httpGet:
            path: /ready
            port: 8080
          periodSeconds: 2
          initialDelaySeconds: 0
          failureThreshold: 3
          successThreshold: 1


ALPACA_POD=$(kubectl get pods -l app=backend \
-o jsonpath='{.items[0].metadata.name}')

kubectl port-forward $ALPACA_POD 48858:8080

kubectl get endpoints alpaca-prod --watch

kubectl edit service backend-prod

kubectl describe service backend-prod



