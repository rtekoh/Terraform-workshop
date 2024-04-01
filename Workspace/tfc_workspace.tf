terraform {

  required_version = ">= 1.6.6"

  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = ">= 0.52.0"
    }
  }
}

provider "aws" {
  # Configuration options
}

locals {
  organization = var.organization
  project_id   = var.project_id
  role_name    = var.role_name

  flattened_account_ids = flatten([for ws in var.workspaces : ws.aws_account_id])
}

resource "tfe_workspace" "workspace" {
  for_each          = { for worksp, workspace in var.workspaces : worksp => workspace }
  name              = each.value.workspace_name
  organization      = local.organization
  project_id        = local.project_id
  auto_apply        = false
  working_directory = each.value.working_dir
  vcs_repo {
    branch         = "main"
    identifier     = each.value.vcs_identifier
    oauth_token_id = each.value.oauth_token_id
  }
}

resource "tfe_variable" "aws_run_role_arn" {
  for_each = tfe_workspace.workspace
  key      = "TFC_AWS_RUN_ROLE_ARN"
  # value        = "arn:aws:iam::${each.value.aws_account_id}:role/${local.role_name}"
  value        = "arn:aws:iam::${local.flattened_account_ids[each.key]}:role/${local.role_name}"
  workspace_id = tfe_workspace.workspace[each.key].id
  category     = "env"
}

resource "tfe_variable" "aws_provider_auth" {
  for_each     = tfe_workspace.workspace
  key          = "TFC_AWS_PROVIDER_AUTH"
  value        = "true"
  workspace_id = tfe_workspace.workspace[each.key].id
  category     = "env"
}
