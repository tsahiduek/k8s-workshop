1. Create 4 new applications
kubectl run backend-prod \
--image=gcr.io/kuar-demo/kuard-amd64:1 \
--replicas=2 \
--labels="ver=1,app=backend,env=prod"

kubectl run backend-test \
--image=gcr.io/kuar-demo/kuard-amd64:2 \
--replicas=1 \
--labels="ver=2,app=backend,env=test"

kubectl run cyberschool-prod \
--image=gcr.io/kuar-demo/kuard-amd64:2 \
--replicas=2 \
--labels="ver=2,app=cyberschool,env=prod"

kubectl run cyberschool-staging \
--image=gcr.io/kuar-demo/kuard-amd64:2 \
--replicas=1 \
--labels="ver=2,app=cyberschool,env=staging"

2. Run some commands with labels
kubectl get deployments --show-labels

kubectl label deployments backend-test "canary=true"

kubectl get deployments -L canary

kubectl label deployments backend-test "canary-"

3. Use label selectors

kubectl get pods --show-labels

kubectl get pods --selector="ver=2"

kubectl get pods --selector="app=backend,ver=2"

kubectl get pods --selector="app in (backend,cyberschool)"

kubectl get deployments --selector="canary"

kubectl delete deployments --all