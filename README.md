# Potee Platform

## Deploy to cloud

### Generate SSl certs
```
sudo certbot --server https://acme-v02.api.letsencrypt.org/directory -d *.defence.potee.ru -d defence.potee.ru --manual --preferred-challenges dns-01 certonly

```
### Deploy with docker compose
```
docker compose -f docker-compose.deploy.yml run deploy apply
```
#### Destroy
```
docker compose -f docker-compose.deploy.yml run deploy destroy
```

### Generate ssh keypair
```
ssh-keygen
```
### deploy wit terrafrom
```
YC_TOKEN=<yandex token> terraform apply -var-file config.tfvars.json
```
## local
### run
```
docker-compose up -d 
# or
docker compose --env-file .env.dev up -d
```
### stop
```
docker-compose down
```

### update
```
docker-compose pull   
docker-compose up -d
```

## Deploy for Kubernetes

### Dev Mode
#### Deploy k3s cluster
For local deployment you can use [k3d](https://k3d.io/v5.6.0/)
```
k3d cluster create -c k3d-config.yml
```

After the cluster is deployed, you need to install the nginx ingress controller
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.1/deploy/static/provider/cloud/deploy.yaml
```

#### Deploy Potee Platform
To deploy helm charts of the platform and its dependencies, you can take [helmwave](https://docs.helmwave.app/0.31.x/)
```
helmwave up --build
```

