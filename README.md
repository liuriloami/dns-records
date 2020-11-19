# Setup

You need to have docker and docker-compose installed.

## Running the application
```
docker-compose build
docker-compose run web rake db:migrate:reset
docker-compose up
```

## Testing the application

```
docker-compose run web rails test
```

## Endpoints

Creating a new DNS and its hostnames:

```
curl -d '{"ip":"12.0.0.2", "hostnames":["aaa", "bbb"]}' -H "Content-Type: application/json" -X POST http://localhost:3000/ 
```

Querying by hostnames (page is required, the rest is optional):

```
curl -d '{"page": 0, "hostnames_required": ["aaa"], "hostnames_ignored: ["bbb"]}' -H "Content-Type: application/json" -X GET http://localhost:3000/
```