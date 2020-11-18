# Setup

You need to have docker and docker-compose installed.

```
docker-compose build
docker-compose run web rake db:migrate:reset
docker-compose up
```
