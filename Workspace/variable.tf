# variable "tfc_hostname" {
#   description = "Hostname for Terraform Cloud"
# }

# variable "tfc_token" {
#   description = "Terraform Cloud API token"
# }

# variable "aws_role_name" {
#   description = "Name of the AWS IAM role for Terraform Cloud to assume"
#   default     = "tfc_role"
# }

variable "organization" {
  description = "Name of the Terraform Cloud organization"
}

variable "project_id" {
  description = "Name of the Terraform Cloud project"
}

variable "role_name" {
  description = "Name of the Terraform Cloud Role for your project"
}



variable "workspaces" {
  description = "List of workspaces to create"
  type = list(object({
    workspace_name = string
    working_dir    = string
    vcs_identifier = string
    oauth_token_id = string
    aws_account_id = string
  }))
}
