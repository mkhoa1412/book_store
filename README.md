# Book Store

This app does: Simple Book Store Api

## Requirements
* Docker

## Provisioning

Run the following commands to prepare your Docker dev env:
```
$ docker-compose build

$ docker-compose run runner chmod +x ./bin/*
$ docker-compose run runner ./bin/setup
```
It builds the Docker image, installs Ruby , creates database, run migrations and seeds.

You're all set! Now you're ready to code!

## Configuration
* Check out docker-compose.yml file

## Running The App
```
$ docker-compose up rails
$ docker-compose up sidekiq
```

## API DOCS
*Spin up your app and check out the awesome, auto-generated docs at /api-docs

## Tests and CI
```
$ docker-compose run runner chmod +x ./bin/ci
$ docker-compose run runner ./bin/ci
```
contains all the tests and checks for the app

`tmp/test.log` will use the production logging format
    *note* the development one.


## Others
```
$ bin/db-{migrate,rollback} - migrate and rollback both dev and test in one command
$ bin/release - Release phase script for Heroku to run migrations
```

## Development notes
* Removes config/database.yml and config/secrets.yml because your app will get all configuration from ENV
* SQL-based schema management so you can use any feature of Postgres you like
* Does Not Business Logic in Active Records. Use A simple base ApplicationService and a service class generator bin/rails g service MyThing to encourage putting code in app/services
* All datetime fields in migrations uses timestamp with time zone which is the proper type in Postgres.
