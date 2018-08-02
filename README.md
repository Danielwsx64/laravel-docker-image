# Laravel Docker Environment

## About
This project was created to generate a Laravel development environment with
docker. This project just has a shell script and a Dockerfile to generate an
image and push it to Docker Hub.

## How to use it?
To generate a local Docker image run the `execute` script with `build` as
argument:

```sh
./execute build
```

To generate a Docker image and push it to Docker Hub:

```
./execute deploy
```

### Observation
The `Dockerfile` contais the steps to install the Laravel environment (PHP,
Laravel installer and Composer). To change PHP, Laravel or Composer version you
should change the `Dockerfile` steps.
