kubectl run backend-prod \
--image=gcr.io/kuar-demo/kuard-amd64:1 \
--replicas=3 \
--port=8080 \
--labels="ver=1,app=backend,env=prod"

kubectl expose deployment backend-prod --type=LoadBalancer

kubectl run cyberschool-prod \
--image=gcr.io/kuar-demo/kuard-amd64:2 \
--replicas=2 \
--port=8080 \
--labels="ver=2,app=cyberschool,env=prod"

kubectl expose deployment cyberschool-prod --type=LoadBalancer

kubectl get services -o wide

ALPACA_POD=$(kubectl get pods -l app=backend \
-o jsonpath='{.items[0].metadata.name}')

kubectl port-forward $ALPACA_POD 48858:8080

#show DNS in KUARD UI

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

kubectl get endpoints backend-prod --watch

kubectl edit service backend-prod

kubectl describe service backend-prod



# Cleanup
kubectl delete deployment backend-prod
kubectl delete deployment cyberschool-prod
kubectl delete service backend-prod
kubectl delete service cyberschool-prod



