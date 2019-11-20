# create ReplicaSet
kubectl apply -f nginx-deployment.yaml

# Get the pod created by the DaemonSet - pay attention to the Node names column
kubectl get pods -lrun=nginx -o wide

# delete ReplicaSet
kubectl delete -f nginx-deployment.yaml

# open a new terminal and run the following command

kubectl get pods -lrun=nginx -o wide --watch

# on your current terminal update the deployment - for example image version - applying updated yamls
kubectl apply -f nginx-deployment-update.yaml

# Go over the other terminal (with the watch command)
# Pay attention to the way K8s replacing the pods by Creating a new ReplicaSet and finally delete the old one

# Cleanup
kubectl delete -f nginx-deployment-update.yaml
