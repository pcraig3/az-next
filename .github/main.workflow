workflow "Build, test, and deploy on push" {
  on = "push"
  resolves = ["Deploy as Azure Container Instance"]
}

action "Install npm dependencies" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  args = "install"
}

action "Run JS linter" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  needs = ["Install npm dependencies"]
  args = "run lint"
}

action "Run Jest unit tests" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  args = "test"
  needs = ["Run JS linter"]
}

action "If personal branch" {
  uses = "actions/bin/filter@24a566c2524e05ebedadef0a285f72dc9b631411"
  needs = ["Run Jest unit tests"]
  args = "branch personal"
}

action "Login to Azure" {
  uses = "Azure/github-actions/login@d0e5a0afc6b9d8d19c9ade8e2446ef3c20e260d4"
  needs = ["If personal branch"]
  secrets = ["AZURE_SERVICE_APP_ID", "AZURE_SERVICE_PASSWORD", "AZURE_SERVICE_TENANT"]
}

action "Login to Azure Container Registry" {
  uses = "actions/docker/login@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD", "DOCKER_REGISTRY_URL"]
  needs = ["Login to Azure"]
}

action "Build container locally" {
  uses = "actions/docker/cli@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  needs = ["Login to Azure Container Registry"]
  args = "build -t aznext.azurecr.io/az-next ."
}

action "Push container to Azure Container Registry" {
  uses = "actions/docker/cli@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  needs = ["Build container locally"]
  args = "push aznext.azurecr.io/az-next"
}

action "Deploy as Azure Container Instance" {
  uses = "pcraig3/github-actions/cli@master"
  needs = ["Push container to Azure Container Registry"]
  secrets = ["AZURE_SERVICE_APP_ID", "AZURE_SERVICE_PASSWORD"]
  env = {
    ACR_LOGIN_SERVER = "aznext.azurecr.io"
  }
}
