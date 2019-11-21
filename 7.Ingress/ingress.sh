# Read https://www.nginx.com/products/nginx/kubernetes-ingress-controller
# Install from https://github.com/nginxinc/kubernetes-ingress/

git clone https://github.com/nginxinc/kubernetes-ingress/
cd kubernetes-ingress/deployments/
# Create Namspace and ServiceAccount
kubectl apply -f common/ns-and-sa.yaml
# Create TLS certificate
kubectl apply -f common/default-server-secret.yaml

# Create configMap
echo '  proxy-protocol: "True"' >> common/nginx-config.yaml
echo '  real-ip-header: "proxy_protocol"' >> common/nginx-config.yaml
echo '  set-real-ip-from: "0.0.0.0/0"' >> common/nginx-config.yaml
kubectl apply -f common/nginx-config.yaml
# Configure RBAC
kubectl apply -f rbac/rbac.yaml

# Deploy the Ingress Controller
kubectl apply -f deployment/nginx-ingress.yaml

# Check that the Ingress Controller is running
kubectl get pods --namespace=nginx-ingress

# Create a Service Type LoadBalancer for the Ingress Controller
kubectl apply -f service/loadbalancer-aws-elb.yaml

NGINX_POD=$(kubectl get pods -lapp=nginx-ingress -o jsonpath="{.items[0].metadata.name}")
kubectl port-forward $NGINX_POD 8080:8080 --namespace=nginx-ingress

cd ../examples
INGRESS_LB_CNAME=$(kubectl get svc nginx-ingress -o jsonpath="{.status.loadBalancer.ingress[0].hostname}")
sed -i.bak   s/cafe.example.com/$INGRESS_LB_CNAME/g complete-example/cafe-ingress.yaml
kubectl apply -f complete-example/.

curl https://$INGRESS_LB_CNAME/coffee --insecure
curl https://$INGRESS_LB_CNAME/tea --insecure


# Cleanup (can take a minute)

kubectl delete namespace nginx-ingress
