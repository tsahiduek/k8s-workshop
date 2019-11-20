# create ReplicaSet
kubectl apply -f daemonset1.yaml

# Get the pod created by the DaemonSet - pay attention to the Node names column
kubectl get pods -lapp=fluentd -o wide

# delete ReplicaSet
kubectl delete -f daemonset1.yaml
