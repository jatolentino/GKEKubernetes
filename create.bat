minikube delete
minikube start --driver=docker --kubernetes-version=v1.25.9

kubectl apply -f prod/app_secrets.yaml
kubectl apply -f prod/app_variables.yaml

minikube ssh
sudo su
mkdir -p /var/lib/data/postgres_data
chmod -R 777 /var/lib/data/postgres_data
chown -R 999:999 /var/lib/data/postgres_data

CTRL+D x 2

kubectl apply -f prod/component_postgres.yaml
kubectl get pods

minikube ssh

ls /var/lib/data/postgres_data
> postgress
CTRL+D x 2


minikube ssh
sudo su
mkdir -p /var/lib/data/static_assets_data
chmod -R 777 /var/lib/data/static_assets_data
chown -R 999:999 /var/lib/data/static_assets_data
CTRL+D x 2
kubectl apply -f prod/job_django.yaml
kubectl get pods
minikube ssh
ls /var/lib/data/static_assets_data
> django_files
CTRL+D x 2


docker build -t joseaidocker/nginx_dev_image:latest ./nginx
docker push joseaidocker/nginx_dev_image:latest


kubectl apply -f prod/component_static_assets.yaml
kubectl get pods

kubectl apply -f prod/component_django.yaml
kubectl get pods

kubectl apply -f prod/component_react.yaml
kubectl get pods

minikube addons enable ingress

kubectl apply -f prod/ingress_service.yaml
minikube ip
192.168.99.109