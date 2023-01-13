Terraform configuration for testing purposes. It creates 3 workspaces without configuration files:
  - 1st workspace `hook_generates_tf` has pre-init hook that generates terraform configuration.
  - 2nd workspace `hook_noop` has pre-init hook that does not generate terraform configuration.
  - 3rd workspace `without_hook` does not have pre-init hook.
 
 Before applying, `scalr_vcs_provider` vcs provider should be created manually on the scalr.
