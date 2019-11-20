# create ReplicaSet
kubectl apply -f replicaset1.yaml

# Get the pod created by the replicaset
kubectl get pods -lapp=kuard

# export pod name to ENV_VAR
RS_POD=$(kubectl get pods -lapp=kuard -o jsonpath="{.items[0].metadata.name}")

# delete pod created by ReplicaSet
kubectl delete pod $RS_POD

# export pod name to  a new ENV_VAR
NEW_RS_POD=$(kubectl get pods -lapp=kuard -o jsonpath="{.items[0].metadata.name}")

if [[ $RS_POD != $NEW_RS_POD ]];then
    echo "Replicaset created a new pod"
fi

kubectl delete -f replicaset1.yaml
