terraform {
  required_providers {
    scalr = {
      source  = "registry.scalr.dev/scalr/scalr"
      version = "1.0.0-rc-develop"
    }
  }
}

variable "account_id" {
  type    = string
  default = "acc-svrcncgh453bi8g"
}

resource "scalr_environment" "pre_init_hook_test" {
  name                    = "hook-test"
  account_id              = var.account_id
  cost_estimation_enabled = false
}

data "scalr_vcs_provider" "test" {
  name       = "hook_test"
  account_id = var.account_id
}

resource "scalr_workspace" "hook_generates_tf" {
  name              = "hook_with_tf"
  environment_id    = scalr_environment.pre_init_hook_test.id
  auto_apply        = true
  vcs_provider_id   = data.scalr_vcs_provider.test.id
  working_directory = "workspace_source"
  hooks {
    pre_init = "chmod +x create_tf.sh && ./create_tf.sh"
  }
  vcs_repo {
    identifier = "DayS1eeper/pre-init-hook-test"
    branch     = "master"
  }
}

resource "scalr_workspace" "hook_noop" {
  name              = "hook_without_tf"
  environment_id    = scalr_environment.pre_init_hook_test.id
  auto_apply        = true
  vcs_provider_id   = data.scalr_vcs_provider.test.id
  working_directory = "workspace_source"
  hooks {
    pre_init = "chmod +x echo.sh && ./echo.sh"
  }
  vcs_repo {
    identifier = "DayS1eeper/pre-init-hook-test"
    branch     = "master"
  }
}

resource "scalr_workspace" "without_hook" {
  name              = "no_hooks"
  environment_id    = scalr_environment.pre_init_hook_test.id
  auto_apply        = true
  vcs_provider_id   = data.scalr_vcs_provider.test.id
  working_directory = "workspace_source"
  vcs_repo {
    identifier = "DayS1eeper/pre-init-hook-test"
    branch     = "master"
  }
}
