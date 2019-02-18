# petclinic-test

howto run:
git clone this repo
cd into cloned folder
edit envs in docker-compose file
```
docker-compose build
docker-compose up -d
```
wait for petclinic download and build anded:
(~40 min on slow pc)
```
docker logs -f --tail 100 spring
```
curl localhost:80
