# Documentation

# Getting Started

## Docker

it’s really simple you need to have docker and docker-compose installed in order to be able to run the project you need to run the following command in order to have the application running.

### X86

```bash
$ docker-compose up --build
```

### ARM or M1 chip

```bash
$ docker-compose -f docker-compose.m1.yml up --build
```

## On your machine

On your machine, you need to have the ruby `3.0.0` version installed or RVM for ruby virtual management.

```bash
$ bundle install

$ rails db:create db:migrate

$ rails s
```