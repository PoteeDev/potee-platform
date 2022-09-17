# Potee Platform

## Deploy to cloud
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

