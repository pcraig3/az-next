workflow "Build, test, and deploy on push" {
  on = "push"
  resolves = ["List Azure container repositories"]
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

action "Login to Azure " {
  uses = "Azure/github-actions/login@d0e5a0afc6b9d8d19c9ade8e2446ef3c20e260d4"
  needs = ["If personal branch"]
  secrets = ["AZURE_SERVICE_APP_ID", "AZURE_SERVICE_PASSWORD", "AZURE_SERVICE_TENANT"]
}

action "List Azure container repositories" {
  uses = "Azure/github-actions/cli@d0e5a0afc6b9d8d19c9ade8e2446ef3c20e260d4"
  needs = ["Login to Azure "]
  env = {
    AZURE_SCRIPT = "az acr repository list --name azNext"
  }
}
