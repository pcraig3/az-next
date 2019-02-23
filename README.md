# Next Hello

This is a tiny proof-of-concept app to trial Azure container deployments.

## Getting started

### [Install `yarn`](https://yarnpkg.com/en/)

`yarn` is a javascript package manager. It downloads project dependencies and runs node applications.

### [Install `docker`](https://docs.docker.com/install/)

A docker container allows a developer to package up an application and all of its parts. This means we can build an app in any language, in any stack, and then run it anywhere — whether locally or on a server.

## Build and run with yarn

```bash
# install dependencies
yarn

# run application in 'dev' mode
yarn dev

# run application in 'prod' mode
yarn build && yarn start
```

On a Mac, press `Control` + `C` to quit the running application.

### Run tests with yarn

```bash
# run unit tests
yarn test

# run code linter
yarn lint
```

## Build and run as a Docker container

```bash
# build an image locally
docker build -t az-next .

# run the container
docker run -it -p 3000:3000 az-next
```

On a Mac, press `Control` + `C` to quit the running docker container.
