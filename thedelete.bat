kubectl delete --all ingress
kubectl delete -A ValidatingWebhookConfiguration ingress-nginx-admission
kubectl delete job -n ingress-nginx ingress-nginx-admission-create ingress-nginx-admission-patch
::minikube addons enable ingress
::kubectl apply -f k8s/ingress_service.yaml
minikube stop
minikube delete -all
docker-compose down -v
docker system prune --all